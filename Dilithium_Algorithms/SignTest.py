from Dilithium_Key import *
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
    combined_bytes = tr + M_prime # Correct concatenation of bytes
    shake = SHAKE256.new()
    shake.update(combined_bytes)
    mu = shake.read(64)  # 512 bits = 64 bytes
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

    for i in range(rows_k):
        w[i] = NTT_inverse(w_ntt[i])

    return w



# #---------------------------------------------------- STEP 13 & 14----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def Decompose(r):
    r_1 = (r + 127) >> 7
    if gamma2 == (q - 1) // 32:
        r_1 = (r_1 * 1025 + (1 << 21)) >> 22
        r_1 &= 15
    elif gamma2 == (q - 1) // 88:
        r_1 = (r_1 * 11275 + (1 << 23)) >> 24
        r_1 ^= ((43 - r_1) >> 31) & r_1

    r_0 = r - r_1 * 2 * gamma2
    r_0 -= (((q - 1) // 2 - r_0) >> 31) & q

    return r_1, r_0


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
def modpm(m, alpha):
    return -((alpha // 2 - m) % q) + (alpha // 2)

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
def Sign(sk, M, rnd, ctx):
    # random_no = 30
    # # print(random_no)
    # random_bytes = random_no.to_bytes((random_no.bit_length() + 7) // 8, byteorder='big')
    # shake = SHAKE256.new()
    # shake.update(random_bytes)
    # rnd = shake.read(32)  #256 bits = 32 bytes

    # secure_random = random.StrongRandom()
    # seed_length = 32  
    # random_no = secure_random.getrandbits(seed_length * 8)   #32 * 8 = 256 bits
    # rnd = IntegerToBytes(random_no, seed_length)


    if len(ctx) > 255:
        return None

    if rnd is None:
        return None

    M_prime = (IntegerToBytes(0, 1)) + (IntegerToBytes(len(ctx), 1)) + ctx + M

    signature = Sign_internal(sk, M_prime, rnd)
    return signature



#---------------------------------------------------- Sign_internal ----------------------------------------------------#
def Sign_internal(sk, M_prime, rnd):
    #--------  Step 1: (𝜌, 𝐾, 𝑡𝑟, 𝐬1, 𝐬2, 𝐭0) ← skDecode(𝑠𝑘)    
    rho, K, tr, s1, s2, t0 = skDecode(sk)
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
    # for i in range(rows_k):
    #     for j in range(cols_l):
    #         print(f"\nA[{i}][{j}] = {A[i][j].tolist()}")


    # #--------  Step 6: 
    mu = compute_mu(tr, M_prime)
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


    # #--------  Step 10: 
    while (z, h) == (None, None):

        # # --------  Step 11:
        y = ExpandMask(rho_double_prime, kappa)
        # print("Vector y:")
        # for i in range(len(y)):
        #     print(f"\ny[{i}] = {y[i]}")


        # #--------  step 12:
        y_ntt = []
        for i in range(len(y)):
            y_ntt.append(NTT(y[i]))

        # for i in range(len(y_ntt)):
        #     print(f"\ny_ntt[{i}] = {y_ntt[i]}")

        w = compute_w(A, y_ntt)
        # for i in range(len(w)):
        #     print(f"\nw[{i}] = {', '.join(map(str, w[i]))}]")


        # #--------  step 13 & 14:
        for i in range(len(w)):
            for j in range(coefficients_per_polynomial):
                w1_coef = HighBits(w[i][j])
                w1[i][j] = w1_coef

        # for i in range(len(w1)):
        #     print(f"\nw1[{i}] = [{', '.join(map(str, w1[i]))}]")


        # #--------  step 15:
        w1_encoded = w1Encode(w1)
        # print(f"\nw1_enc : {w1_encoded.hex()}") 

        c_h = compute_commit_hash(mu, w1_encoded)
        # print(f"\nc_h : {c_h.hex()}") 


        # #--------  step 16:
        v_c = SampleInBall(c_h)
        # print(f"\nv_c : {v_c}") 


        # #--------  step 17:
        v_c_hat = NTT(v_c)
        # print(f"\nv_c_hat : {v_c_hat}") 


        # #--------  step 18:
        cs1 = multiply_vc_hat_and_s1(v_c_hat, s1_ntt)
        # for index, poly in enumerate(cs1):
        #     print(f"Result cs1 {index}: {poly}")


        # #--------  step 19:
        cs2 = multiply_vc_hat_and_s2(v_c_hat, s2_ntt)
        # for index, poly in enumerate(cs2):
        #     print(f"\nResult cs2 {index}: {poly}")


        # #--------  step 20:
        z = compute_signers_response_z(y, cs1)
        # for index, poly in enumerate(z):
        #     print(f"\nz {index} = {poly}")


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

    
    # #--------  step 33:
    z = [ [ modpm(x, q) for x in zi ] for zi in z ]   
    sig = sigEncode(c_h, z, h)
    # print("Encoded Signature:", sig)


    # #--------  step 34:  
    return sig


# m_hex = 'BB88DE13CC6B3CE2A061816397DFF40349B8F2533D6F86AF2DC73882DC7AD854B7BEA6283F358B498E4CDD4ACE062AF74021A9FC642F7D61B01E4858B5CA2E7DAC4F6AC2D73524F3B45683BAD136CE7620ED4D0BF784A421807D5D632940A01206AF819C7D4BE58E2CA1810851FEDF0D82719955DC352D2DEBE70DBCC35095355ED4B8B04450E8B9432A4025B18F088E3920B4BE76FEE6BF60C5EC650428B86DC733975A8C182E36300F54C3F48DF2D74C12E47CBE5C68F52E44C9728619C897EE35B2A46755A01E9D721BDEF415042937737FCDBFA7A279D7FEAF2C37CCA94CEE48D9F8B62A4BCCDFA32360D640F4DE71003E3066B7DFC72E69CEB22280C2C1D3F21EE9F4752A76A3E5849F6FD1E2A6B0D1ACF98D7D3E0C32CD6EE0A0EEB164439332B8E6A5B01EF9CCADA5C412959C496FA1D3E5055405AA058FA4932342518A48B1046D2C1552A591FEE282E912C1720104E3403CADF4979FE5FCF756AFF8AE308ED6D3079D4E52E10F92F9EBA58F0186FA431CF081191F840B0B7B6833B524F8CD287913476C4421D4C155CD78A2AB60642B0BD4F17C5808EA1B73E26F26A36560728D51EF66B105180D6CDA21099F7FEDEB8ED61A856A5B796979F9725C2F409C77D61821994BF30126595BD7D2716414E63F9F673FDD368AAFEA3A59B32C716944AD936DB4652D8AF616F8BCF50B64A4D3AD9FCE98854A0B44CC86C6D5EA181E1551E2371637C1850D37ED8AE87B5636B11043CC4B87BA27E4AAA575EA3AC1E3A0E1374B4115B41779EA5653AC2FB5EA41710196CDB9FF4D9C244CCA4E3A6F648B99B99E6598A7B2A611854AD5574B3174F4B05A9F4C7D5A7F9DE4E9C85B28FE342BABF8602ADEF2CCA0E34B137FEA800D15267739A48F36921AC8438A74538A5C98CABFD858479A6BEAFE2F830F7448E16E5D1BE68597FFEB8351A7C549DCCBCF665A87C7CBEF6A310CFCD1A37BB9E3C28D8D673F23F1B720928BC8C378A767BBA2AA3DF236D66ED69C3FD73CB891774C14206CB1986D7AA44DBD9E3AC60770E4388935F206F7E2FA3FFFAD9D9505DE30C68FCAE88BA044D89C43EA18D0ADD649DC6D4196C23DDBDE09F752DC4616E738D66FE89D514D517A1FF82FE1D6EBF291DCF3B47D3DB49FAE2C1B35DC1B64D0CB25C004C23FB33D90EA7F4B62EB07FA3FD46D4117E20CF9DA3127508EDD3CF96B5A1AE9D12AC6FF1E0B9689368FD1D57CAA131915CF2BE60E912E893ED1482774B5DA34C084A452ED821143C91B8B09BB6522D705B0AF458FDB6E757DB4822F4E60A5C1988D3B9F8118CAC514BAC27D07AC3EC0009687197772C1FC23266BB84726FE8B9893B5FA26226D8CCA27B750D7929CE86DCA554CEB3D544D8761C2EFA594ECCC0B9A0FA494AB8A56E37357CCBF495EE615114C34F20925A7374AA5B079510021F4779A3678B1FAB9FE485611E58C972D123B40A5B6E044A6D087568F65899E39843C585777702156B7031536AFF62F8DD90B39178A845D4CCE11A79908B1BD147F0607141970394C52CB2A142D12B777215E40229D1D408B5172C7B0BD7421E1174349676D51EB1A2DD734CB10AFBE96C1640E2A93D457C86D7466058A672387963AC3ECA979DC2F88D4F6F4E6AD00B7775217E1FBB81CDA2FF3E04A8174EE24CB1B78106636E9D8460AE2B0AE87BC4EBFE779798BEFA30F4B2923925122396B84A57BA2FBBF9FF1CCA3D09FC868045285326DBBE073CA46BD74D00627B67B16A9AB18B3DA42802CA35AED563560841B304A48CD39E3169D5955E47CEB424BBAF906FF4C84349DCEFFA69EF710249CA2F1BC487370751CA8F79CE8771080D24151FE7AD10375D878BDB943568B0E3941CDF5FCBE849DB874D703C25CAD5B8743FD2A064A656997ED7BCD1028EAF4ABBAF895D398C3D06C5748E03A9A625346CEE12D4B37C932D6A08EC08FF0F40054129D25B0F32969704862CF7C3C0926AD0ABD05283E0749DFA989FD023419CE26C41C44C1105E03D30A6C5281A8DB609D90F4A8BE1BC471565F350FF7FD73DD9BE477589CA6B6A2B37C20EDB05EA915B881FA7512B4B29E1CB9EA77B21180F3F71DB12ABD94E19705065D71BAE12A41D6E82178F06AFA4C0F35EC7E3EBCA810EEDBCFDB9F7FFDD9F9EAE00C01C2D4093728335B226ECEC6F850AABB6EDA82E6135E338FEB626A0A4343E6BF31F39DB9F15B58C0A2BC6E216ABA3E0A89401DE0AA11FF9F7BC56590E9D61791903881365B34FC8BBA2DF813FDAF5451F353E05BD477F8B329F8EDEDE713ED9ACF6CD1BE0C315E6A9CF157A3C5299869B34CA4D670E7FD61F78D67B99E987D12D0BD3D9619089E972A5142D2D9F04091B28C866426BD570D03EBC7AAC888BBDFC4309406BB4AF639B1CA94C8F4004DBF3730425977414364C3F8E00F414F62BF1937D326AF78C2F4E5FDA669221B06E3FA09F92A47D4179757447E7E3FDB375833B7E3FAE448C8315B892D8ED99AA842761FEB79A89576FD32B86E78AA1E7E138C7F03CB5D7C03E682A2C0BED14A4FC5BC289CBDEFC4D836824077E82E4BD31C47FFD9285F656A13DDDA3D80CCF83DAAA09CC37E3AC61366A86230C88FE1C1C0228DB60FF4F06280A7D784022A8099B20807C9EF0BF6A9FE0FCD19C1E512EA61DD680166AB46B26A8CCF75E4C42234C12415DA7A429E2824F36156A75AEF4F1CBB48245E42BEC8E3810C8E341B9D60657573B0342EA6AA02C64424732934761B0390812587A935D54A0820EDA1EF6817D580DBD10A53AC3D6EAC07789312EBA2F9302483B535E55045BB88DAE418AECEBCB88615D6704B2814375A6DF97B91D2E304054FBE25D05B95B142567BC074C81901F324E5CEA6FF7FE3A885917B028811039B59E1C7D0B0DD6CE47D70CB0BBDBCEBE8FC03A3D67E5DE7178FD5ADC7792FB321877D31B401FDF7C7BB4D04E697727E3258F5313B338B198A95C9CEA8A528318157627E3BEE44DD2E3ED66198E77CE15D7D52EFABB00A8405B920F8DF2C369E1DE5EC6378CFFC8448A0E245B791D3AA8EA8FADE4345176DBBDB4D38738D7E10848EF26B920B8A575C9535C31EC55F53F293865D3CBB2D10517E6F0227581A7E64000B17E4C53D14063699705668EC2ADE75918D0BE21190A6D730CF20908EF6068C2C0AF03EC98320913F4E4BD3E8814E8F93B64F210A900BFB56AD485EA64685E5443EEA3ABA712CE0AE15721D8BFC84792EC6D613DB4BCA1645AAAFF564CEA7B26BD7D06CFB7C5669CA2B6CD4A751A606A2AC2C4DF8F0BC15ABE6B710DBF60B1AEA196E320227265A14CF04986075FDFDBB8BEB6FE992CCDA09D39421D76B38CEC3CD4AA44F61918E1C16E0C5CAC5E840078F7C14C5CFE835BDBE9394B64271F494CE5E49B6048C379FB13FD1C78A989D674B644960CD9D211600A8DB98313F5BE8A74F63624F8B6BD8DCE163F1FE3666992CC5F69E5A9CE331C19841706413811430D0FDF131C92C4102A3FCB0CFE3AF421940ACB2548BB9A540942C7CCC6E7BD99232D4AE7880DAD9774A2A134124C6ED150DDEE0EC1347047E76710CA2A48B2CB63ED596D1C450F82099C69B90371BB2A1CF21579A311767C9A572C878FB723EE5BA4A5DD668BC36657912047B10AAF13FEA0715E270E7019CACFE8DFBB571329D41AC3B295B9DA8E404C88132B313C8336E7EE92D107F91F574B97410A13A2EFA45B88ED9DD60BED435256202DD7555200F2F36E36C7855D08518891971DD0A66CB5FA80833D762A46256A5664F170EFDD2E5EDABA1F95AEDC0C2B14004202ADB8CB21AEB732705FDDAD7DDC665169237588E3A9CB89618E64B1B3039D53C7C401C0B7DE24E678C0C82A641BADFA509F1FB867C816147E609946953FF3487A31B91BD6B6F088EBDD50F9BE39F9FAD4F9E1B65C179580DFD877A85700C3C9CA86545E1672F432556BCFFD58F5ECE618E04768F9BDCEDE9FCF8ECAE945E4ABDAA9EFAB2002EB1C62EB741AE625506EA360EE3BBCAE73BA217460F18F571DC986B622A9549057072BF4177D67E052F0C11E21F70F6B620D43443B770A17107A58EC0B3926118CD567FDA71EBBC6FE6CFB6B18AFC166A581EF58CAE165BEF4D302C334664D4E6BE9BDF36DB4FD51561E25A1360EEA233D8D42588791FB3AC8C5A2946001D5240E2179F2C30EF3F7EA76EAC62C3E74A76772C5099A5B6FE5DC80F251ACD7C840D451EFAAA651960296ECB3F777D7CBBB175F6C2842A975EDDC104459018AE49E6E629DE7F99BF6D39B17A310494BF620DA03DC817626A37239D9469D25212A3A0CFD336E0895BEF3E0D24EF61BBFB722BD798A2BC4E19B91C0A68DA89FD7B5EA0DCEC0006EA3AA642FA16301B87418B781E674DB0B2808CD0DA211A309EE9553E4076A3467490922549553CDAE9943E2598797352B99E167F3374977C5FF09836F11AAFC56723F192BA074FC9FFC044729E7A2036204658F03B0A6A65234C2C981F3C9B2E06DCA0B9B09399128E528A9DDABAC98C89B7728C48B6A107DCA125541ADD1C8A5D1F2C6706A9ED93D3A1A6DD12470748A146763BC6F84D3344A6629D266DB334309CE4E2036AD3FFF2398596E9E5AE3F3F4CC2CD124C26420130D2D9A9E0CC59378FC3C086479563148987EC3B4F6316800C7DF2C7EBC4F35D6B2998CEE7897925C1E54CFC2E4CBD3F89B8D63F83AE2BC9A0C13359F11A1DDCBFEFD304D4ECCD60C770EA7A2CB7423FD7E4E208A0B34C3F2E6DBAB5E94196AB6079B4708C95236BC177F2CFED59365B771C9B88C67D56745F5F9AF8578FD8BA40D7D46313B95C726DA886F627AB9EC8651244C1FBD68334DDC729E8089113486E1A7B8C229B6DBBDE965F49B2333B8948A2896BD746D4BC64F6FF80743B09CCF2382A6335E76AEE7D1C08D092E72BDC489E24115D0580987DB1738D8AEBD8E766F231DD0F83286DB3E77158DF526DD7838A6C4C226FBE23153AE75D541ED6EF74E72200BFAF66B4EB47801C2996D2640EC7AB61DA4CCE89F2F08C763813B434039AEEB2B77B9F2FEB4699F1F9B114A2B01F710852DA8A6399DA7B5EDE51FA8538'
# M_prime = bytes.fromhex(m_hex)

# sk_hex = 'D7E1512B8AF9E945A9B6CC64CB8C2632AA5DCB6347CE44B710813B7281F950DEB3D121D7952025BCBB7B4716F6FEE3C606A9A2BD0C8FCCAA783E810DCA0E964FFF0B72CA2E03B7895830F0E739A4159F1E45F87AB1A11C4923EC5BE72EC50EBC6B836969E8CFD7F27A4AEBFBC6E125D5153DA443A0DBFCD61E3E63A916BEDA32593426E3242C0B10505AA870084971020544C3B4040B194619844093300D41286448C6490A346084C09190C28098985114868C0CC5491C4440A4B8304292601AC628CCC605CB246214996101182D2045681A988410472E118220E0307180103209A709CC3606890626D2344423C7819B406282247298066D52228AC0428C00214A1243111006924384690229829128861B00881A047214351001A785218800C80869CC3052449008CA002A80B610D4B0605434925C161289C44902B3611889001C88854116508138720A04124CB64D0944420914200C066D64260198B2680BB3092487081A0185D22248C1A66444181220030C0345921BB851D8360E40242DC32030811682CCA8311A404C1A8340DB3465CB960840C06C12206981C04D92848099C649C014880A116618A80091C488D488306220401025641C40400805500C0829999429E4266293A2084AB23090B44CCC804413808841442A20C710C1462D1093900412864A424002938912B42C10166E53348DDCA410DB946402090420C82583428E22C7210C0444509664CB362102324264304521178E6288858CA221D9107223C710A3148A11C98909374061482940860411C180C44081C22866CC489023382D2134495B086ECB2891C4B82DA1C460141546100242834025131410C444010147280C8024509024C4B261101885494686A2207111412623012C821230CC224A98326804B96DD2440418800414918CD4A660D9C644D3A00061106A188591903024DBA2451912454C100A0C3844DC28481325325C8201138750C830018A126948B80509108C443652918671D2126EA09064A2C089483006E0260153302D8A18410A240092B630D10289C9088111A550929200D1B87143228551866D144092A128019432058904852292504A340209886DC84865A2382E010441A046600A140D13482121868DDBA2648C36660A966108A730E23645E306221C172C8B184821376E522068C9A26D93C62DC812242144109814891483840330448C1466A38004914280230249829245CC320660A629C2447024B629E0804803B00989262519A18C18C10014C411CCC44142B260D4464009040A5C0260089685C3361019924C02082AE32010C940100A908CE08205D4A08592B82503388A030069C9448042986D8A8645D2008548804CCA426890C241503612A300515294640B135100A5690C371114160D02052909214613A78C08318201C9808B402563804802A26DC1C84408160C99102CE3280ED4226250007118009023458E498048A4128D9C2229404231121932C13802A18665000752DAB22D09198503400E110852218944D4C2290312224AA0814A480E090360033946600812D4080084400203A05118382121050A22426C1A0512243586843068E0C88421032C642050433009138989DB06685428421005641029860B472CD1848952A60D24464900B78C1B480A4AA651DBC20801B80109C089221709C9120A59466D202572622608A084855A366110C70410412E10A0509CA82D92A625E444000A026CE31006599229D322800B249019C87098484A5C064520A88C943462429605A0A4041482480813219B288022408249060C13275250402E4428811A25500BA9041A020CA3207094248153260118855042C2218C22891BC16D5C482053104D204749C1044A4326290BB125C3022E10328E9B44455B04219CC60D9C4604C1C604C3162A91C40848008208C71049422AD2360192088E8C342A8B226C6218882126428C38620B150612899182C86C18A11098448211072589C68C10332C0CA17023102DD9020A19326C19A848A402000CC7298B263081B05108380122C809819261C48281C2B864A130005B402A40B06919170908327291A08912B66C0AC269D2B8044230204C100518278C41242CD0886DDBA605D83685DC347024C36913382419A265DC4020D846310A086DA3426C12C230CB3490C120920034690A2571490486CC024089A0818C925021210158026C13948DE4180574D6C76CCD106A8026F32F2A7603CBD7C430958E4A600F67A1585FDDB2800C1438AC78605A4E4F7173C6C34B55D8DD72390FBBDABAE0EB0A78F31E731197E0FA9C00519DA00353010578D75CB095BBE3371687C10A18E5D3E63C08469C7108E0395261A1477281FF77877414288304BC71EC8B76AD3A7EA2BD0398533C647ECFE4BF8101DC3F4D4B3BE197D4A6ED9CC409867467C84244A4A1B2014F16418EB2DAFC8EAC97640896D0EDDF73940987726E7DAB763150DF38F2EA263E28220612B3F5469FA0B8773F059B454C7604F7EA801CA286C169FF29C5E50400AD0F7A5C5BDFE9BD491A6FFE877F32CEE3B9829D5884656B76F628BAF0F02C0F183D466C9A2A749650C465CB63FE1514174899F5A1B3EF72E6EEBCFA6B128F7218CC67D9BE1B95D774A9261246032C504C81B432243694FA8DC492C5F69B186153C3311EE3BAA67A7222FE41D09A275FE84FC8BBA917387A6E1C05783393D067074AB63558784200EC8C4EA6DF0D4049F205B30F3FA6B03B80990147175B45626E580A2668FDAF5422E69B2DBDED5616B2EED3D4B640A1A2F0040CB29004C7B1449D015C2A8D4EAE2765291958AB847025122C8479756AAC189935CADFC6777887B21FAF885F0AFF5DE7A4884818ED8B6FBF9072773E40AB7924D2ADE96F173B77999E2A2B0D7DC1013B52BFA7004D6DD24A91A8BA80AEF1C55A728634F763812A8EA2EF138295F6854E629E4D5D6422CDEF0DEF9BA157C1235A3C1A8D871514AA1539854EE9A49A5F318ECC75622EEAE73B943763CD3A04D17D337BA048C440533E436C789E52426B35CA4DE9DB302559B269354C47B77EF254D14ADC3A05AA58B8EEF4B8EF17BAF7999E5FCE00902BF20C244F4EF2238C30CD95BB40AB3983E87BD2EE9E3F2504239E8A421D176E419B5E9D86395E3312190C6FAAFF66BF1EF589EBA6C733627B59818C8CB652E6197E71FA5D736B8F31BAC357E03270C70D153A18BD125F96688970791F48685A4C732C0423A26CC53865FC1474C76CC62306C8D70F8AE33872A085F9B7E660835036B88DC629D68D40077ED388F975656A0F1FFE4DF848F536FD86E06CAC2808D60AE3C72AF71D01A67EAE06E83385382EE13A475EDCF08A95C0834E3F7D805FFC6D6078D9D11EB5490DD45F3D56FCAEF66F1AD480C1109220CD830A66623A2CAB83E96D385AF4491725BACB1F149986949648AF605DC8BC5FC1AC0193A94609F023C906BEF494A83FFDB7741D4431FF1FDF126128D467F52D8C14F5FA419D4A7F4A3C43FD4996D194937906C9F76F68E7EC9B22E5162E4832EE5E1DF602BD1318F115D939A625D4C310E3B8FA0B15EBA06912B747BB0BBD96D3ABBAD0757676E6B4675F7319A786CFF938B6E94C5EB9DC1EEF01B70461759E8B1191E79296C99C7C7D858A7CC9085A6B7F470404A4A66D800EC3878228D4A11EF4F43F58721F58A39184989AA755BDB322988EE15C1CB13D3C7FC71F3D91B8F2A341A328455BBB0056E974A07A5184F36BA999967BF1F777D9811F92D746EED75504193E13B3E9BF072844677A8994FE36DFAF5AD5E93F6738DBDECE517D4E48C4AF8B40F0C7B5B0FDB9C21A9CD717BF0F7A74D639960F332EB747018E5A790E4BD0F8E741278DAF36B82A8180A35B98C96520CBAE36D290D0DD8A63B15CC8065C601A66F7F40F7FA94B596A08D99CAA296A9E4B063A7173E57F0283E046A37455A914E1077EBD6D2C03ADB88D19E47BCC3AE8E10B47F44385830E32BB0BFEC5318C9DB4EC9909961FB9CEA7EB2DEFECF6B5CB79B2181B5D896026C1A5020F80C6543099CFDAAD5F7AE0A3926FAC2DFDE9E109CAFA140A5F522CFA3424163333816F7E6243517C9DF6201D31620D6E2D4C8D4FDB880F3975012D14C4B68C25DA2A551921D4B98B7C8EF7BB8FCD493178433FDF9FC8A3C120D65B9765DC5E0DE1E93967059156357750C995F439E3DD596EF97F38FEADDDB8AA04EBAF6558263A2058C80DBD2AB10DDC26F71F605167EE5E7111CB3B0CDC6C695E27452F01CDE289AE2E5E1535A8C7072374E025A6CD39584CA6110C853FD8162770912FEFA40B4A3A6A89BCD21DCA7BC4E9729B3ADBA71B052AF7DE00FAD9C70DBEE422F601A1CE21DE1AF8FD6690E031A7D5FDD139077BF14679894C83867BF824F61094AAAC5C02CB2ADFD2354FEE62D57B2B6FDC632CA15619C63150D08871602CB8FCEEBC0B8E3B0E74E66CF2F85271C1851FE855A51270D4EE827C34247D3D50A85866A14C47E1378DA4BEE3F49EAB8B57245352FA014072BF1DAD398A3066BA77E1CC7C62CD2B04C7038F6F052DACDEDE5B0D285C1FD4217BDCA2106DA0ACF24E79AB59DF7865BE6CA145057949C5EFFD007526ED7173E69882B50B2098BA4CEAEDA04C5DD2AF214B3B9789E8C1E9A2B550B58A0143777EAA7607F7446D97C9B5F9D3294CE671CE61662327410380FE36861CA6C2CC3F0CF97A5976F55CB5F2622F6CBAE8D9D118D2CCDE975F447C2787143E311F8EFB98E37C514915E1A82ABA9CAF9B0685B5B057A4ABC2D47E6692A7E8541E42151946F625200CA6C47DC887B6FEFF77F25FD64233166C4701AB82F6EB915F4C05728EF28429C0A8CF23E21DED7BC674870CED01089A9361DCA8235BA552BA13CE1548612E596BF9CE86753EC5BE9ABCE246CF9366FA01C58E3E19B7DEBA4F9A00C223CF34AFAF58E81C6B1792A436F6669D354FFD62477E0A3FDF9C786997967D52B429AD8027D04842261E28077480D3DCA510427DE742DC9A5B137D01723823D0AD64C2F08F7123D3F06C4A530D69AA0B2845ADC9C49A263D8A0AAB7C2CB8D1F318228CE899C284D3ACD90E8CC6A41805E66229F3FC9141CA4BA4724F941C1CC4569A6D9F5D6EC2A3521DBDEFC791CFF03FF903B649D3493924874A328DA7FECDF20E7B85550EC9331873F1348A5A99F0943C80E7642070B89CDDF06ED0DABD95D03AE8EA78398691B48C600CB1EF5C2978B20B61A38912F15C94694506C877E96F1147449BAF52C28BBC08B97E40FC585FBF5ABD87527FD6347DA90C96D5326A1FFFB4F084A36FD5463A252F57B9C4170E85996BB6084BE1FDE0EC7A77FE3FD71AEBD1762D64093FABC37561FB44BC9FC2ABC0584BFBF56772E33BF725382E283A5F0A9CBA362C61E8BEFE8E8A319D8450EEC119B5564BF54EF5E889CC7A16FFB968E6D16B0F2BE0D2794C38281207EB11ABBF379E221546AFFFC56F12BD327A043ECC8429EC78B0EFDEEF0E5803B30656386458914B8F2621F1DCDE3E84A458EEB1362D32F8094A3219F18EC40CB126CB3259536EF41B11F4DE77DB2DB82D21AC4D0A01ADD4A03E15913C50E5A9FB04E16AF30C24BADB421BAA06C8DB22B235011D1A172C26C828111CA1F8314CC6CC0AD6E6F67FB5DC696D34CD4C3B717918CBFE9879CCBDAE883B0CAB0105C39EE2AA724C8931F7ACC03DDADC781A548469C3808498DDB9835430675B7196C74287B1BC23129DC5B73486FDC24F34834BE646932186D5AD7B9D81FB111BB43302C104F741810F9037AA3DE04A6CAF6EA8CB3BE817F7D79FE88A3833C6F50B3982A76E0C656FEEE5ABC533DD49F2E067A1C0DC15D57CDB0B82DA33AD5AE347BA07B60B2F0C36E3C0B1BB59BA93F64720A9EE7EF9E5535C801DDCDEEE9B8BB02B4FE81DC45B30B62BA855307224615BC3498BEEB0738F11C079F813C3DED243A3F70718A7576232294E642F18F57BF9AB325C28A602AC44E88D9380A21EAE9AE158322638B68FBA66107F9F0641FDC35C5F425DD9A91A84A9103B0A182659429450BD0C1E981B6BE557A5A697053200A94A28C330E03EA48C7EE5D8C3569D5C74C3486FE580D63F127BC265DDF1E636B5A745FC24568712464284F1A944A41BAB0DE7A3F3CC0557140F38273104C78D9AE33531D61A5D9B45E0071790C89A5AD5484209770FE049B0B019B159237608A2B34365D6672FBA95D1834A541D861F2DF622D9A96F0BA39431E6DD5C64AB62A6B41715C79AA5B4322BBCBEC0C9344D098D4682800213134ED403C87D74E6B6DCCD30AAF978692894B8168EA310EE4E230EEE26A784E16941B8F57315627F532BF8774928EB84DFF843107536517892B6BDC00EB1246FB07F8306A131C448CCEE98111DC0B79CA644600387A60D8B610676C11E82D5B22C3E0ED49E0E731B4C55C4B7AEEB36657A2BEF631DD78EE92CCD9DD6793C30E8FF9D9DADAE09B05990F39EDD4655B625D9E1886C38D5FC2FECA9AA1DA99EB95F7E3552C6E24067F576AF4A55034C554D3E3B4C86DF7A968C57811B9796262172C30C893B5B6A1C45D95D5BB1F289D3AD5FBD63BA7855017DDC0D1757BAC2F0B3A2AE881FB334CC275108CCB67FE17E48B66C3453B7778C647A19C7AC95F92CDE32A58F0CA3D7B03C7735E15A7E6656C0DF97B94313CA022877D50D49697199F51674621BBA4C8948730441E34F1EB3A1259687039F283B30566BD1D0138FEA410BC82226793AE20E6230539FA70D3CF980DA2D252F2D2025EBD027141FAA89128382085DECC1A1CB0837DFC8B183F60288548200A0DE3D4D7CA4FC0B2BC7BA7C023D68CDD26C04EE1CC862A00547451EFA121AD3A8AE159CC3DAC289325D99AD8C645B4D802963DEC440730A7E4777E16C2C594D25B6600E90587174AD541113FC389EB5B9A53B164C0EF4D3FAC96325E86B5D45'
# sk = bytes.fromhex(sk_hex)

# rnd_h = '1C8F427ED06E6179DB1D1B4A61D2FA9B7DB8F60062F98E4F1613DD59446D4F09'
# rnd = bytes.fromhex(rnd_h)

# ctx_h = '9A471AA2E12F035BFB29743B090C58CCA8A8FB1D1ECC68373124ADD3CA5CA350592457B99FA24378D615CDCA30C073C4E7A7B6E7BEA82EF201B94525A7D971C8F3A4FB7DD13F745E90B9C64DBE'
# ctx = bytes.fromhex(ctx_h)

# signature = Sign(sk, M_prime, rnd, ctx)
# print("Signature:", signature.hex())



import json

def load_json(file_path):
    with open(file_path, 'r') as file:
        return json.load(file)

def load_expected_results():
    return load_json('SignT/expectedResults.json')

def main():
    data = load_json('SignT/prompt.json')
    expected_results = load_expected_results()

    # Filter the test group and expected results for tgId 17
    test_group = next((tg for tg in data['testGroups'] if tg['tgId'] == 17 and tg['testType'] == "AFT"), None)
    expected_group = next((tg for tg in expected_results['testGroups'] if tg['tgId'] == 17), None)

    if not test_group or not expected_group:
        print("Test group with tgId: 17 not found.")
        return

    # Process each test case
    for test, expected in zip(test_group['tests'], expected_group['tests']):
        if 241 <= test['tcId'] <= 255:  # Check if tcId is between 241 and 255
            message = test['message']
            rnd = test['rnd']
            sk = test['sk']
            context = test['context']

            expected_sign_hex = expected['signature']
            
            message_bytes = bytes.fromhex(message)  # Convert hex to bytes
            rnd_bytes = bytes.fromhex(rnd)
            sk_bytes = bytes.fromhex(sk)
            context_bytes = bytes.fromhex(context)

            print(f"Processing Test Case ID: {test['tcId']} with rnd: {rnd}")

            # Perform the signing operation
            signature = Sign(sk_bytes, message_bytes, rnd_bytes, context_bytes)
            sign_hex = signature.hex() 

            # Compare the results
            if sign_hex.lower() == expected_sign_hex.lower():
                result = "PASS"
            else:
                result = "FAIL"

            # print(f"Test Case ID: {test['tcId']}")
            # print("Generated Signature:", signature)
            # print("Expected Signature:", expected_signature)
            print("Test Result:", result)
            print("\n")  # New line for better readability between test cases

if __name__ == "__main__":
    main()
