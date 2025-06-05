from Key import *
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
def Sign(sk_hex, M_hex, rnd, ctx):
    M = bytes.fromhex(M_hex)
    sk = bytes.fromhex(sk_hex)
    print(ctx)
    # rnd = bytes.fromhex(rnd_hex)

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

