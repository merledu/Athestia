from core.key import *
import hashlib


#---------------------------------------------------- PARAMETERS ----------------------------------------------------#
gamma1 = 524288
gamma2 = 261888
Lambda = 256 
hamming_weight = 60
beta = 120
omega = 75


#---------------------------------------------------- FUNCTIONS ----------------------------------------------------#
def BytesToBits(z):
    alpha = len(z) 
    y = [0] * (8 * alpha) 
    z_prime = list(z)
    
    for i in range(alpha):
        for j in range(8):
            y[8 * i + j] = z_prime[i] % 2
            z_prime[i] = z_prime[i] // 2
    return y



#---------------------------------------------------- STEP 1 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def BitUnpack(v, a, b):
    c = bitlen(a + b)
    z = BytesToBits(v)
    w = [] 

    for i in range(256):
        bits = z[i*c : (i+1)*c]
        w_i = b - BitsToInteger(bits, c) 
        w.append(w_i)
    return w


#----------------------------------- skDecode -----------------------------------#
def skDecode(sk, l=cols_l, k=rows_k, eta=eta, d=d):
    bit_offset = 0

    rho = sk[bit_offset:bit_offset + 32]
    bit_offset += 32

    K = sk[bit_offset:bit_offset + 32]
    bit_offset += 32

    tr = sk[bit_offset:bit_offset + 64]
    bit_offset += 64

    bitlen_eta = 32 * bitlen(2 * eta)
    y = []
    for i in range(l):
        y.append(sk[bit_offset:bit_offset + bitlen_eta])
        bit_offset += bitlen_eta

    z = []
    for i in range(k):
        z.append(sk[bit_offset:bit_offset + bitlen_eta])
        bit_offset += bitlen_eta

    w = []
    for i in range(k):
        w.append(sk[bit_offset:bit_offset + 32 * d])
        bit_offset += 32 * d

    s1 = []
    for i in range(l):
        s1.append(BitUnpack(y[i], eta, eta))

    s2 = []
    for i in range(k):
        s2.append(BitUnpack(z[i], eta, eta))

    t0 = []
    for i in range(k):
        t0.append(BitUnpack(w[i], ((2 ** (d - 1)) - 1), (2 ** (d-1))))

    return rho, K, tr, s1, s2, t0



# #---------------------------------------------------- STEP 6 ----------------------------------------------------#
#----------------------------------- Compute_mu -----------------------------------#
def compute_mu(tr, M_prime):
    # print(M_prime)
    # print((tr + M_prime).hex)
    combined_bytes = tr + M_prime # Correct concatenation of bytes
    shake = SHAKE256.new()
    # print(combined_bytes)
    shake.update(combined_bytes)
    mu = shake.read(64)  # 512 bits = 64 bytes
    # print(mu.hex())
    return mu


# #---------------------------------------------------- STEP 11 ----------------------------------------------------#
#----------------------------------- ExpandMask -----------------------------------#
def ExpandMask(rho_doub_prime, k):
    c = 1 + bitlen(gamma1 - 1)
    y = []
    
    for r in range(cols_l):
        rho_prime = rho_doub_prime + IntegerToBytes(k + r, 2)
        shake = SHAKE256.new()
        shake.update(rho_prime)
        v = shake.read(32 * c)
        y_r = BitUnpack(v, gamma1 - 1, gamma1)
        y.append(y_r)

    return y



# #---------------------------------------------------- STEP 12 ----------------------------------------------------#
#----------------------------------- Compute_w -----------------------------------#
def compute_w(A, y_ntt):
    w_ntt = []
    for _ in range(rows_k):
        vector_ntt_t = [0] * coefficients_per_polynomial
        w_ntt.append(vector_ntt_t)

    w = []
    for _ in range(rows_k):
        vector_invntt_w = [0] * coefficients_per_polynomial
        w.append(vector_invntt_w)

    for i in range(rows_k):
        for j in range(cols_l):
            w_ntt[i] += A[i][j] * y_ntt[j]
    # print(w_ntt[0])

    for i in range(rows_k):
        w[i] = NTT_inverse(w_ntt[i])
    # print(w[0])        
    
    return w



# #---------------------------------------------------- STEP 13 & 14----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def modpm(m, alpha):
    return -((alpha // 2 - m) % alpha) + (alpha // 2)

def Decompose(r):
    rp = r % q
    r0 = modpm(rp, 2*gamma2)
    if rp - r0 == q - 1:
        r1 = 0
        r0 -= 1
    else:
        r1 = (rp - r0) // (2*gamma2)
    return (r1, r0)

def HighBits(w):
    r_1, _ = Decompose(w)
    return r_1


#----------------------------------- Compute_w1 -----------------------------------#
w1 = []
for _ in range(rows_k):
    vectorw1 = [0] * coefficients_per_polynomial
    w1.append(vectorw1)



# #---------------------------------------------------- STEP 15----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def w1Encode(w1):
    w1_encoded = []
    for i in range(rows_k):
        packed_coeff = simple_bit_pack(w1[i], (q - 1) // (2 * gamma2) - 1)
        w1_encoded.extend(packed_coeff) 
    return bytes(w1_encoded)


#----------------------------------- Compute_commit-hash -----------------------------------#
def compute_commit_hash(mu, w1_encoded):
    # w1_encoded_bytes = b''.join(w1_encoded)
    data = mu + w1_encoded
    shake = SHAKE256.new()
    shake.update(data)
    commit_hash = shake.read(Lambda // 4)      
    return commit_hash



# #---------------------------------------------------- STEP 16----------------------------------------------------#
#----------------------------------- compute_verfify_challenge -----------------------------------#
def SampleInBall(seedc_h):
    shake = hashlib.shake_256()
    shake.update(seedc_h)
    buf = bytearray(shake.digest(168))

    signs = int.from_bytes(buf[:8], byteorder='little')
    pos = 8  # Start reading bytes from position 8

    c = [0] * 256

    for i in range(256 - hamming_weight, 256):
        while True:
            if pos >= 168:
                buf = bytearray(shake.digest(168))
                pos = 0
            b = buf[pos]
            pos += 1
            if b <= i: 
                break

        # Swap values and set new coefficient
        c[i] = c[b]
        c[b] = 1 - 2 * (signs & 1) 
        signs >>= 1  # Shift sign bits

    return c



# #---------------------------------------------------- STEP 18----------------------------------------------------#
#----------------------------------- multiply v_c_hat and s1_ntt -----------------------------------#
def multiply_vc_hat_and_s1(v_c_hat, s1_ntt):
    results = []

    for poly in s1_ntt:
        multiplied_poly = []
        for i in range(len(poly)):
            product = (poly[i] * v_c_hat[i])
            multiplied_poly.append(product)
        
        invntt_result = (NTT_inverse(multiplied_poly))

        results.append(invntt_result)

    return results



# #---------------------------------------------------- STEP 19----------------------------------------------------#
#----------------------------------- multiply v_c_hat and s2_ntt -----------------------------------#
def multiply_vc_hat_and_s2(v_c_hat, s2_ntt):
    results = []

    for poly in s2_ntt:
        multiplied_poly = []
        for i in range(len(poly)):
            product = poly[i] * v_c_hat[i]
            multiplied_poly.append(product)
        
        invntt_result = (NTT_inverse(multiplied_poly))
        
        results.append(invntt_result)

    return results



# #---------------------------------------------------- STEP 20----------------------------------------------------#
#----------------------------------- compute_z -----------------------------------#
def compute_signers_response_z(y, cs1):
    z = []
    for i in range(len(y)):  
        sum_poly = []
        for j in range(len(y[i])):  
            sum_result = (y[i][j] + cs1[i][j]) % q 
            sum_poly.append(sum_result)
        z.append(sum_poly)
    return z



# #---------------------------------------------------- STEP 21 & 22----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def LowBits(r):
    _, r0 = Decompose(r)
    return r0


#----------------------------------- compute_r0 -----------------------------------#
def compute_r0(w, cs2):
    results = []
    for i in range(len(w)):  
        processed_polynomial = []
        for j in range(len(w[i])): 
            result_coefficient = (w[i][j] - cs2[i][j]) % q  
            result_coefficient = LowBits(result_coefficient)  
            processed_polynomial.append(result_coefficient)
        results.append(processed_polynomial)
    return results



# #---------------------------------------------------- STEP 23----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def compute_infinity_norm(vector):
    max_value = 0
    for poly in vector:
        for coeff in poly:
            adjusted_coeff = modpm(coeff, q)
            max_value = max(max_value, abs(adjusted_coeff))
    return max_value



# #---------------------------------------------------- STEP 25----------------------------------------------------#
#----------------------------------- multiply_vc_hat_and_t0 -----------------------------------#
def multiply_vc_hat_and_t0(v_c_hat, t0_ntt):
    results = []

    for poly in t0_ntt:
        multiplied_poly = []
        for i in range(len(poly)):
            product = (poly[i] * v_c_hat[i])
            multiplied_poly.append(product)
        
        invntt_result = (NTT_inverse(multiplied_poly))
        
        results.append(invntt_result)

    return results



# #---------------------------------------------------- STEP 26 & 27----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def MakeHint(x, r):
    r1 = HighBits(r)
    v1 = HighBits(r + x)
    return int(r1 != v1)


#----------------------------------- compute_hints -----------------------------------#
def compute_hints(ct0, w, cs2):
    hints = []
    for i in range(len(w)):  
        hint_poly = []
        for j in range(len(w[i])):  
            x = (-ct0[i][j]) % q
            sub_result = (w[i][j] - cs2[i][j]) % q
            r = (sub_result + ct0[i][j]) % q   
            hint_poly.append(MakeHint(x, r))
        hints.append(hint_poly)
    return hints



# #---------------------------------------------------- STEP 33----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def HintBitPack(h):
    y = bytearray(omega + rows_k)
    index = 0

    for i in range(rows_k):
        for j in range(256):
            if h[i][j] != 0:
                y[index] = j
                index += 1
        y[omega + i] = index

    return y


#----------------------------------- sigEncode -----------------------------------#
def sigEncode(c_h, z, h):
    sigma = c_h  
    for i in range(cols_l):
        sigma += BitPack(z[i], gamma1 - 1, gamma1)
    sigma += HintBitPack(h)

    return sigma



#---------------------------------------------------- MAIN FUNCTION ----------------------------------------------------#
def Sign(sk_b, m_b):
    # print(len(M))
    # print(len(ctx))
    # random_no = 30
    # # print(random_no)
    # random_bytes = random_no.to_bytes((random_no.bit_length() + 7) // 8, byteorder='big')
    # shake = SHAKE256.new()
    # shake.update(random_bytes)
    # rnd = shake.read(32)  #256 bits = 32 bytes

    secure_random = random.StrongRandom()
    seed_length = 32  
    random_no = secure_random.getrandbits(seed_length * 8)   #32 * 8 = 256 bits
    rnd = IntegerToBytes(random_no, seed_length)
    # print(rnd)


    sk = bytes.fromhex(sk_b)

    ctx_h = '9A471AA2E12F035BFB29743B090C58CCA8A8FB1D1ECC68373124ADD3CA5CA350592457B99FA24378D615CDCA30C073C4E7A7B6E7BEA82EF201B94525A7D971C8F3A4FB7DD13F745E90B9C64DBE'
    ctx = bytes.fromhex(ctx_h)

    M = bytes.fromhex(m_b)

    if len(ctx) > 255:
        return None

    if rnd is None:
        return None
    # print(ctx.hex())
    M_prime = (IntegerToBytes(0, 1)) + (IntegerToBytes(len(ctx), 1)) + ctx + M

    signature = Sign_internal(sk, M_prime, rnd)
    return signature



#---------------------------------------------------- Sign_internal ----------------------------------------------------#
def Sign_internal(sk, M_prime, rnd):
    #--------  Step 1: (𝜌, 𝐾, 𝑡𝑟, 𝐬1, 𝐬2, 𝐭0) ← skDecode(𝑠𝑘)    
    # print(len(M_prime))
    # print(M_prime)
    rho, K, tr, s1, s2, t0 = skDecode(sk)
    # print(t0)
    # print(f"\nρ : {rho.hex()}")
    # print(f"\nK : {K.hex()}")
    # print(f"\ntr : {tr.hex()}")

    # print("Vector s1:")
    # for i in range(len(s1)):
    #     print(f"\ns1[{i}] = {s1[i]}")
    
    # print("Vector s2:")
    # for i in range(len(s2)):
    #     print(f"\ns2[{i}] = {s2[i]}")

    # for i in range(len(t0)):
    #     print(f"\nt0[{i}] = [{', '.join(map(str, t0[i]))}]")

    
    # #--------  Step 2:
    s1_ntt = []
    for i in range(len(s1)):
        s1_ntt.append(NTT(s1[i]))

    # for i in range(len(s1_ntt)):
    #     print(f"\ns1_ntt[{i}] = {s1_ntt[i]}")


    # #--------  Step 3: 
    s2_ntt = []
    for i in range(len(s2)):
        s2_ntt.append(NTT(s2[i]))

    # for i in range(len(s2_ntt)):
    #     print(f"\ns2_ntt[{i}] = {s2_ntt[i]}")


    # #--------  Step 4:
    t0_ntt = []
    for i in range(len(t0)):
        t0_ntt.append(NTT(t0[i]))


    # for i in range(len(t0_ntt)):
    #     print(f"\nt0_ntt[{i}] = {t0_ntt[i]}")
  

    # #--------  Step 5: 
    A = ExpandA(rho)
    # print(A[0][0])
    # print(A[0][0])
    # for i in range(r  ows_k):
    #     for j in range(cols_l):
    #         print(f"\nA[{i}][{j}] = {A[i][j].tolist()}")


    # #--------  Step 6: 
    # print(tr.hex())
    mu = compute_mu(tr, M_prime)
    
    # print(mu.hex())
    # print(f"\nmu : {mu}") 
    # print(f"\nmu : {len(mu)}") 
    # print(f"\nmu : {mu.hex()}") 

    
    # #--------  Step 7:
    combined = K + rnd + mu
    shake = SHAKE256.new()
    shake.update(combined)
    rho_double_prime = shake.read(64)
    # print(f"\nrho_double_prime : {rho_double_prime}") 
    # print(f"\nrho_double_prime : {len(rho_double_prime)}") 
    # print(f"\nrho_double_prime : {rho_double_prime.hex()}") 


    # #--------  Step 8: 
    kappa = 0

    # #--------  Step 9: 
    (z, h) = (None, None)
    count = 0


    # #--------  Step 10: 
    while (z, h) == (None, None):
        
        # # --------  Step 11:
        # if count == 0:
        #     print(rho_double_prime)
        # print(kappa)
        # if count == 0:
        y = ExpandMask(rho_double_prime, kappa)
        # if count == 0:
            # print(y)
        # print("Vector y:")
            # for i in range(len(y)):
            #     print(f"\ny[{i}] = {y[i]}")


        # #--------  step 12:
        y_ntt = []
        for i in range(len(y)):
            y_ntt.append(NTT(y[i]))

        # if count == 0:
        #     for i in range(len(y_ntt)):
        #         print(f"\ny_ntt[{i}] = {y_ntt[i]}")
        # if count == 0:
        #     print(len(y_ntt),len(y_ntt[0]))
        # if count == 0:
        w = compute_w(A, y_ntt)
        # if count == 0:
        #     for i in range(len(w)):
        #         print(f"\nw[{i}] = {', '.join(map(str, w[i]))}]")


        # #--------  step 13 & 14:
        for i in range(len(w)):
            for j in range(coefficients_per_polynomial):
                w1_coef = HighBits(w[i][j])
                w1[i][j] = w1_coef

        # if count == 0:    
        #     for i in range(len(w1)):
        #         print(f"\n[{', '.join(map(str, w1[i]))}]")


        # #--------  step 15:
        w1_encoded = w1Encode(w1)
        # if count == 0:
        #     print(len(w1_encoded))
        #     print(f"\nw1_enc : {w1_encoded.hex()}") 
        
        
        c_h = compute_commit_hash(mu, w1_encoded)
        # if count == 0:                    
        #     print(f"\nc_h : {c_h}") 


        # #--------  step 16:
        v_c = SampleInBall(c_h)
        # if count == 0:
        #     # print(''.join(reversed(c_h)))
        #     print(f"\nv_c : {v_c}") 


        # #--------  step 17:

        v_c_hat = NTT(v_c)
        # if count == 0:
        #     print(f"\nv_c_hat : {v_c_hat}") 


        # #--------  step 18:
        cs1 = multiply_vc_hat_and_s1(v_c_hat, s1_ntt)
        # for index, poly in enumerate(cs1):
        #     print(f"Result cs1 {index}: {poly}")


        # #--------  step 19:
        cs2 = multiply_vc_hat_and_s2(v_c_hat, s2_ntt)
        # if count == 0:
        #     print(len(cs2),len(cs2[0]))
            # for index, poly in enumerate(cs2):
            #     print(f"\n{poly}")


        # #--------  step 20:
        z = compute_signers_response_z(y, cs1)
        # if count == 0:
        #     print(len(z))
        #     for index, poly in enumerate(z):
        #         print(f"\n{poly}")


        # #--------  step 21 & 22:
        r0 = compute_r0(w, cs2)
        # for index, poly in enumerate(r0):
        #     print(f"\nr0 {index} = {poly}")


        # #--------  step 23, 24 & 25:
        # norm_z = compute_infinity_norm(z)
        # print(f"\infinity norm s_r_z: {norm_z}") 
        # norm_r0 = compute_infinity_norm(r0)
        # print(f"\ninfinity norm r0: {norm_r0}") 

        if (compute_infinity_norm(z) >= gamma1 - beta or compute_infinity_norm(r0) >= gamma2 - beta):
            (z, h) = (None, None)  
        else:
            ct0 = multiply_vc_hat_and_t0(v_c_hat, t0_ntt)
            # for index, poly in enumerate(ct0):
            #     print(f"\nResult ct0 {index}: {poly}")

            # #--------  step 26 & 27:
            h = compute_hints(ct0, w, cs2) 
            # print("Hint Vector (h):")
            # for poly_index, hint_poly in enumerate(h):
            #     print(f"\nh[{poly_index}]: {hint_poly}")

            # #--------  step 28 - 30:
            inf_norm_ct0 = compute_infinity_norm(ct0)
            # print(inf_norm_ct0)
            count_ones = sum(1 for poly in h for coeff in poly if coeff != 0)
            # print(count_ones)

            if inf_norm_ct0 >= gamma2 or count_ones > omega:
                (z, h) = (None, None)


        # #--------  step 31 & 32:       
        kappa = kappa + cols_l
        count += 1

    
    # #--------  step 33:
    z = [ [ modpm(x, q) for x in zi ] for zi in z ]   
    sig = sigEncode(c_h, z, h)
    # print("Encoded Signature:", sig)


    # #--------  step 34:  
    return sig



# m_hex = 'BB88DE13CC6B3CE2A061816397DFF40349B8F2533D6F86AF2DC73882DC7AD854'
# M_prime = bytes.fromhex(m_hex)



# sk_hex = 'D7E1512B8AF9E945A9B6CC64CB8C2632AA5DCB6347CE44B710813B7281F950DEB3D121D7952025BCBB7B4716F6FEE3C606A9A2BD0C8FCCAA783E810DCA0E964FFF0B72CA2E03B7895830F0E739A4159F1E45F87AB1A11C4923EC5BE72EC50EBC6B836969E8CFD7F27A4AEBFBC6E125D5153DA443A0DBFCD61E3E63A916BEDA32593426E3242C0B10505AA870084971020544C3B4040B194619844093300D41286448C6490A346084C09190C28098985114868C0CC5491C4440A4B8304292601AC628CCC605CB246214996101182D2045681A988410472E118220E0307180103209A709CC3606890626D2344423C7819B406282247298066D52228AC0428C00214A1243111006924384690229829128861B00881A047214351001A785218800C80869CC3052449008CA002A80B610D4B0605434925C161289C44902B3611889001C88854116508138720A04124CB64D0944420914200C066D64260198B2680BB3092487081A0185D22248C1A66444181220030C0345921BB851D8360E40242DC32030811682CCA8311A404C1A8340DB3465CB960840C06C12206981C04D92848099C649C014880A116618A80091C488D488306220401025641C40400805500C0829999429E4266293A2084AB23090B44CCC804413808841442A20C710C1462D1093900412864A424002938912B42C10166E53348DDCA410DB946402090420C82583428E22C7210C0444509664CB362102324264304521178E6288858CA221D9107223C710A3148A11C98909374061482940860411C180C44081C22866CC489023382D2134495B086ECB2891C4B82DA1C460141546100242834025131410C444010147280C8024509024C4B261101885494686A2207111412623012C821230CC224A98326804B96DD2440418800414918CD4A660D9C644D3A00061106A188591903024DBA2451912454C100A0C3844DC28481325325C8201138750C830018A126948B80509108C443652918671D2126EA09064A2C089483006E0260153302D8A18410A240092B630D10289C9088111A550929200D1B87143228551866D144092A128019432058904852292504A340209886DC84865A2382E010441A046600A140D13482121868DDBA2648C36660A966108A730E23645E306221C172C8B184821376E522068C9A26D93C62DC812242144109814891483840330448C1466A38004914280230249829245CC320660A629C2447024B629E0804803B00989262519A18C18C10014C411CCC44142B260D4464009040A5C0260089685C3361019924C02082AE32010C940100A908CE08205D4A08592B82503388A030069C9448042986D8A8645D2008548804CCA426890C241503612A300515294640B135100A5690C371114160D02052909214613A78C08318201C9808B402563804802A26DC1C84408160C99102CE3280ED4226250007118009023458E498048A4128D9C2229404231121932C13802A18665000752DAB22D09198503400E110852218944D4C2290312224AA0814A480E090360033946600812D4080084400203A05118382121050A22426C1A0512243586843068E0C88421032C642050433009138989DB06685428421005641029860B472CD1848952A60D24464900B78C1B480A4AA651DBC20801B80109C089221709C9120A59466D202572622608A084855A366110C70410412E10A0509CA82D92A625E444000A026CE31006599229D322800B249019C87098484A5C064520A88C943462429605A0A4041482480813219B288022408249060C13275250402E4428811A25500BA9041A020CA3207094248153260118855042C2218C22891BC16D5C482053104D204749C1044A4326290BB125C3022E10328E9B44455B04219CC60D9C4604C1C604C3162A91C40848008208C71049422AD2360192088E8C342A8B226C6218882126428C38620B150612899182C86C18A11098448211072589C68C10332C0CA17023102DD9020A19326C19A848A402000CC7298B263081B05108380122C809819261C48281C2B864A130005B402A40B06919170908327291A08912B66C0AC269D2B8044230204C100518278C41242CD0886DDBA605D83685DC347024C36913382419A265DC4020D846310A086DA3426C12C230CB3490C120920034690A2571490486CC024089A0818C925021210158026C13948DE4180574D6C76CCD106A8026F32F2A7603CBD7C430958E4A600F67A1585FDDB2800C1438AC78605A4E4F7173C6C34B55D8DD72390FBBDABAE0EB0A78F31E731197E0FA9C00519DA00353010578D75CB095BBE3371687C10A18E5D3E63C08469C7108E0395261A1477281FF77877414288304BC71EC8B76AD3A7EA2BD0398533C647ECFE4BF8101DC3F4D4B3BE197D4A6ED9CC409867467C84244A4A1B2014F16418EB2DAFC8EAC97640896D0EDDF73940987726E7DAB763150DF38F2EA263E28220612B3F5469FA0B8773F059B454C7604F7EA801CA286C169FF29C5E50400AD0F7A5C5BDFE9BD491A6FFE877F32CEE3B9829D5884656B76F628BAF0F02C0F183D466C9A2A749650C465CB63FE1514174899F5A1B3EF72E6EEBCFA6B128F7218CC67D9BE1B95D774A9261246032C504C81B432243694FA8DC492C5F69B186153C3311EE3BAA67A7222FE41D09A275FE84FC8BBA917387A6E1C05783393D067074AB63558784200EC8C4EA6DF0D4049F205B30F3FA6B03B80990147175B45626E580A2668FDAF5422E69B2DBDED5616B2EED3D4B640A1A2F0040CB29004C7B1449D015C2A8D4EAE2765291958AB847025122C8479756AAC189935CADFC6777887B21FAF885F0AFF5DE7A4884818ED8B6FBF9072773E40AB7924D2ADE96F173B77999E2A2B0D7DC1013B52BFA7004D6DD24A91A8BA80AEF1C55A728634F763812A8EA2EF138295F6854E629E4D5D6422CDEF0DEF9BA157C1235A3C1A8D871514AA1539854EE9A49A5F318ECC75622EEAE73B943763CD3A04D17D337BA048C440533E436C789E52426B35CA4DE9DB302559B269354C47B77EF254D14ADC3A05AA58B8EEF4B8EF17BAF7999E5FCE00902BF20C244F4EF2238C30CD95BB40AB3983E87BD2EE9E3F2504239E8A421D176E419B5E9D86395E3312190C6FAAFF66BF1EF589EBA6C733627B59818C8CB652E6197E71FA5D736B8F31BAC357E03270C70D153A18BD125F96688970791F48685A4C732C0423A26CC53865FC1474C76CC62306C8D70F8AE33872A085F9B7E660835036B88DC629D68D40077ED388F975656A0F1FFE4DF848F536FD86E06CAC2808D60AE3C72AF71D01A67EAE06E83385382EE13A475EDCF08A95C0834E3F7D805FFC6D6078D9D11EB5490DD45F3D56FCAEF66F1AD480C1109220CD830A66623A2CAB83E96D385AF4491725BACB1F149986949648AF605DC8BC5FC1AC0193A94609F023C906BEF494A83FFDB7741D4431FF1FDF126128D467F52D8C14F5FA419D4A7F4A3C43FD4996D194937906C9F76F68E7EC9B22E5162E4832EE5E1DF602BD1318F115D939A625D4C310E3B8FA0B15EBA06912B747BB0BBD96D3ABBAD0757676E6B4675F7319A786CFF938B6E94C5EB9DC1EEF01B70461759E8B1191E79296C99C7C7D858A7CC9085A6B7F470404A4A66D800EC3878228D4A11EF4F43F58721F58A39184989AA755BDB322988EE15C1CB13D3C7FC71F3D91B8F2A341A328455BBB0056E974A07A5184F36BA999967BF1F777D9811F92D746EED75504193E13B3E9BF072844677A8994FE36DFAF5AD5E93F6738DBDECE517D4E48C4AF8B40F0C7B5B0FDB9C21A9CD717BF0F7A74D639960F332EB747018E5A790E4BD0F8E741278DAF36B82A8180A35B98C96520CBAE36D290D0DD8A63B15CC8065C601A66F7F40F7FA94B596A08D99CAA296A9E4B063A7173E57F0283E046A37455A914E1077EBD6D2C03ADB88D19E47BCC3AE8E10B47F44385830E32BB0BFEC5318C9DB4EC9909961FB9CEA7EB2DEFECF6B5CB79B2181B5D896026C1A5020F80C6543099CFDAAD5F7AE0A3926FAC2DFDE9E109CAFA140A5F522CFA3424163333816F7E6243517C9DF6201D31620D6E2D4C8D4FDB880F3975012D14C4B68C25DA2A551921D4B98B7C8EF7BB8FCD493178433FDF9FC8A3C120D65B9765DC5E0DE1E93967059156357750C995F439E3DD596EF97F38FEADDDB8AA04EBAF6558263A2058C80DBD2AB10DDC26F71F605167EE5E7111CB3B0CDC6C695E27452F01CDE289AE2E5E1535A8C7072374E025A6CD39584CA6110C853FD8162770912FEFA40B4A3A6A89BCD21DCA7BC4E9729B3ADBA71B052AF7DE00FAD9C70DBEE422F601A1CE21DE1AF8FD6690E031A7D5FDD139077BF14679894C83867BF824F61094AAAC5C02CB2ADFD2354FEE62D57B2B6FDC632CA15619C63150D08871602CB8FCEEBC0B8E3B0E74E66CF2F85271C1851FE855A51270D4EE827C34247D3D50A85866A14C47E1378DA4BEE3F49EAB8B57245352FA014072BF1DAD398A3066BA77E1CC7C62CD2B04C7038F6F052DACDEDE5B0D285C1FD4217BDCA2106DA0ACF24E79AB59DF7865BE6CA145057949C5EFFD007526ED7173E69882B50B2098BA4CEAEDA04C5DD2AF214B3B9789E8C1E9A2B550B58A0143777EAA7607F7446D97C9B5F9D3294CE671CE61662327410380FE36861CA6C2CC3F0CF97A5976F55CB5F2622F6CBAE8D9D118D2CCDE975F447C2787143E311F8EFB98E37C514915E1A82ABA9CAF9B0685B5B057A4ABC2D47E6692A7E8541E42151946F625200CA6C47DC887B6FEFF77F25FD64233166C4701AB82F6EB915F4C05728EF28429C0A8CF23E21DED7BC674870CED01089A9361DCA8235BA552BA13CE1548612E596BF9CE86753EC5BE9ABCE246CF9366FA01C58E3E19B7DEBA4F9A00C223CF34AFAF58E81C6B1792A436F6669D354FFD62477E0A3FDF9C786997967D52B429AD8027D04842261E28077480D3DCA510427DE742DC9A5B137D01723823D0AD64C2F08F7123D3F06C4A530D69AA0B2845ADC9C49A263D8A0AAB7C2CB8D1F318228CE899C284D3ACD90E8CC6A41805E66229F3FC9141CA4BA4724F941C1CC4569A6D9F5D6EC2A3521DBDEFC791CFF03FF903B649D3493924874A328DA7FECDF20E7B85550EC9331873F1348A5A99F0943C80E7642070B89CDDF06ED0DABD95D03AE8EA78398691B48C600CB1EF5C2978B20B61A38912F15C94694506C877E96F1147449BAF52C28BBC08B97E40FC585FBF5ABD87527FD6347DA90C96D5326A1FFFB4F084A36FD5463A252F57B9C4170E85996BB6084BE1FDE0EC7A77FE3FD71AEBD1762D64093FABC37561FB44BC9FC2ABC0584BFBF56772E33BF725382E283A5F0A9CBA362C61E8BEFE8E8A319D8450EEC119B5564BF54EF5E889CC7A16FFB968E6D16B0F2BE0D2794C38281207EB11ABBF379E221546AFFFC56F12BD327A043ECC8429EC78B0EFDEEF0E5803B30656386458914B8F2621F1DCDE3E84A458EEB1362D32F8094A3219F18EC40CB126CB3259536EF41B11F4DE77DB2DB82D21AC4D0A01ADD4A03E15913C50E5A9FB04E16AF30C24BADB421BAA06C8DB22B235011D1A172C26C828111CA1F8314CC6CC0AD6E6F67FB5DC696D34CD4C3B717918CBFE9879CCBDAE883B0CAB0105C39EE2AA724C8931F7ACC03DDADC781A548469C3808498DDB9835430675B7196C74287B1BC23129DC5B73486FDC24F34834BE646932186D5AD7B9D81FB111BB43302C104F741810F9037AA3DE04A6CAF6EA8CB3BE817F7D79FE88A3833C6F50B3982A76E0C656FEEE5ABC533DD49F2E067A1C0DC15D57CDB0B82DA33AD5AE347BA07B60B2F0C36E3C0B1BB59BA93F64720A9EE7EF9E5535C801DDCDEEE9B8BB02B4FE81DC45B30B62BA855307224615BC3498BEEB0738F11C079F813C3DED243A3F70718A7576232294E642F18F57BF9AB325C28A602AC44E88D9380A21EAE9AE158322638B68FBA66107F9F0641FDC35C5F425DD9A91A84A9103B0A182659429450BD0C1E981B6BE557A5A697053200A94A28C330E03EA48C7EE5D8C3569D5C74C3486FE580D63F127BC265DDF1E636B5A745FC24568712464284F1A944A41BAB0DE7A3F3CC0557140F38273104C78D9AE33531D61A5D9B45E0071790C89A5AD5484209770FE049B0B019B159237608A2B34365D6672FBA95D1834A541D861F2DF622D9A96F0BA39431E6DD5C64AB62A6B41715C79AA5B4322BBCBEC0C9344D098D4682800213134ED403C87D74E6B6DCCD30AAF978692894B8168EA310EE4E230EEE26A784E16941B8F57315627F532BF8774928EB84DFF843107536517892B6BDC00EB1246FB07F8306A131C448CCEE98111DC0B79CA644600387A60D8B610676C11E82D5B22C3E0ED49E0E731B4C55C4B7AEEB36657A2BEF631DD78EE92CCD9DD6793C30E8FF9D9DADAE09B05990F39EDD4655B625D9E1886C38D5FC2FECA9AA1DA99EB95F7E3552C6E24067F576AF4A55034C554D3E3B4C86DF7A968C57811B9796262172C30C893B5B6A1C45D95D5BB1F289D3AD5FBD63BA7855017DDC0D1757BAC2F0B3A2AE881FB334CC275108CCB67FE17E48B66C3453B7778C647A19C7AC95F92CDE32A58F0CA3D7B03C7735E15A7E6656C0DF97B94313CA022877D50D49697199F51674621BBA4C8948730441E34F1EB3A1259687039F283B30566BD1D0138FEA410BC82226793AE20E6230539FA70D3CF980DA2D252F2D2025EBD027141FAA89128382085DECC1A1CB0837DFC8B183F60288548200A0DE3D4D7CA4FC0B2BC7BA7C023D68CDD26C04EE1CC862A00547451EFA121AD3A8AE159CC3DAC289325D99AD8C645B4D802963DEC440730A7E4777E16C2C594D25B6600E90587174AD541113FC389EB5B9A53B164C0EF4D3FAC96325E86B5D45'
# sk = bytes.fromhex(sk_hex)
# # print(sk)

# rnd_h = '1C8F427ED06E6179DB1D1B4A61D2FA9B7DB8F60062F98E4F1613DD59446D4F09'
# rnd = bytes.fromhex(rnd_h)

# ctx_h = '9A471AA2E12F035BFB29743B090C58CCA8A8FB1D1ECC68373124ADD3CA5CA350592457B99FA24378D615CDCA30C073C4E7A7B6E7BEA82EF201B94525A7D971C8F3A4FB7DD13F745E90B9C64DBE'
# ctx = bytes.fromhex(ctx_h)
# print(len(ctx))

# signature = Sign(sk, M_prime, rnd, ctx)
# print("Signature:", signature.hex())