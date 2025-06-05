from Key import *
from Sign import *


#---------------------------------------------------- STEP 1 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def SimpleBitUnpack(v, b):
    c = bitlen(b)
    z = BytesToBits(v)
    w = [] 

    for i in range(256):
        bits = z[i*c : (i+1)*c]
        w_i = BitsToInteger(bits, c) 
        w.append(w_i)
    return w


#----------------------------------- pkDecode -----------------------------------#
def pkDecode(pk):
    rho = pk[:32]
    t1 = []
    y = bitlen(q - 1)
    b = (2 ** (y - d)) - 1

    poly_size = (len(pk) - 32) // 8  
    for i in range(8):
        start = 32 + i * poly_size
        end = start + poly_size
        t1_i = SimpleBitUnpack(pk[start:end], b)  
        t1.append(t1_i)
    return rho, t1



#---------------------------------------------------- STEP 2 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def HintBitUnpack(y):
    h = [[0]*256 for _ in range(8)]  
    Index = 0  
    First = 0  

    for i in range(8):
        if y[omega + i] < Index or y[omega + i] > omega:  
            return None  
        First = Index
        while Index < y[omega + i]:
            if Index > First:
                if y[Index - 1] >= y[Index]: 
                    return None
            h[i][y[Index]] = 1
            Index += 1

    for i in range(Index, omega):
        if y[i] != 0:
            return None

    return h


#----------------------------------- sigDecode -----------------------------------#
def sigDecode(sigma):
    bl = 32 * (1 + int(gamma1 - 1).bit_length())  # block length for z elements
    cl = Lambda // 4  
    
    c_tilde = sigma[:cl]
    offset = cl

    z = []
    for i in range(cols_l):
        xi = sigma[offset: offset + bl]
        z.append(BitUnpack(xi, gamma1 - 1, gamma1))  
        offset += bl

    y = sigma[offset: offset + omega + rows_k]  
    h = HintBitUnpack(y)  

    return c_tilde, z, h



#---------------------------------------------------- STEP 9 ----------------------------------------------------#
#----------------------------------- compute_w_approx -----------------------------------#
def compute_w_approx(A, z, v_c, t1):
    z_ntt = []
    for i in range(len(z)):
        z_ntt.append(NTT(z[i]))
    # for i in range(len(z_ntt)):
    #     print(f"\nz_ntt[{i}] = {z_ntt[i]}")

    v_c_ntt = NTT(v_c)
    # print(f"\nv_c_ntt = {v_c_ntt}")

    t1_ntt = []
    for t1_i in t1:
        scaled_t1_i = []
        for coeff in t1_i:
            scaled_coeff = coeff * (2**d)  
            scaled_t1_i.append(scaled_coeff) 
        transformed_poly = NTT(scaled_t1_i)  
        t1_ntt.append(transformed_poly)
    # for i in range(len(t1_ntt)):
    #     print(f"\nt1_ntt[{i}] = {t1_ntt[i]}")
    
    Az_mul = []
    for _ in range(rows_k):
        vector = [0] * coefficients_per_polynomial
        Az_mul.append(vector)

    for i in range(len(A)):  
        for j in range(len(z_ntt)): 
            for k in range(256): 
                Az_mul[i][k] = (Az_mul[i][k] + (A[i][j][k] * z_ntt[j][k]) % q) % q

    # for i in range(rows_k):            
    #     print(f"\nAz_mul[{i}] = {', '.join(map(str, Az_mul[i]))}")


    c_t1_products = [[0] * 256 for _ in range(len(t1_ntt))]
    for i in range(len(t1_ntt)):
        for k in range(256):
            c_t1_products[i][k] = (v_c_ntt[k] * t1_ntt[i][k]) % q

    # for i in range(len(c_t1_products)):
    #     print(f"\nc_t1_products[{i}] = {c_t1_products[i]}")


    w_approx = []
    for i in range(len(t1)):
        final_poly = [(Az_mul[i][k] - c_t1_products[i][k]) % q for k in range(256)]
        w_approx.append(NTT_inverse(final_poly))

    return w_approx



#---------------------------------------------------- STEP 10 & 11 ----------------------------------------------------#
#----------------------------------- use_hint -----------------------------------#
def use_hint(h, r):
    m = (q - 1) // (2*gamma2)
    r1v = []
    for i in range(256):
        r1, r0 = Decompose(r[i])
        if h[i] == 1 and r0 > 0:
            r1 = (r1 + 1) % m
        if h[i] == 1 and r0 <= 0:
            r1 = (r1 - 1) % m
        r1v += [ r1 ]
    return r1v



#---------------------------------------------------- MAIN FUNCTION ----------------------------------------------------#
def Verify(pk_hex, M_hex, sign_hex, ctx):
    pk = bytes.fromhex(pk_hex)
    M = bytes.fromhex(M_hex)
    sign = bytes.fromhex(sign_hex)

    if len(ctx) > 255:
        return False  

    M_prime = (IntegerToBytes(0, 1)) + (IntegerToBytes(len(ctx), 1)) + ctx + M

    # print(pk.hex())
    # print()
    # print(M_prime.hex())
    # print()
    # print(sign.hex())

    return Verify_internal(pk, M_prime, sign)  



#---------------------------------------------------- Verify_internal ----------------------------------------------------#
def Verify_internal(pk, M_prime, sign):
    # #--------  Step 1:
    rho, t1 = pkDecode(pk)
    # print(f"\nρ : {rho.hex()}")

    # for i in range(len(t1)):             
    #     print(f"\nt1[{i}] = [{', '.join(map(str, t1[i]))}]")


    # # #--------  Step 2:
    c_h, z, h = sigDecode(sign)
    # print(f"\nc_h : {c_h.hex()}") 

    # for index, poly in enumerate(z):
    #     print(f"\nz {index} = {poly}")

    # print("Hint Vector (h):")
    # for poly_index, hint_poly in enumerate(h):
    #     print(f"\nh[{poly_index}]: {hint_poly}")


    # # #--------  Step 3 & 4:
    # if h == 1:
    if h == None:
        return False


    # # #--------  Step 5:
    A = ExpandA(rho)
    # for i in range(rows_k):
    #     for j in range(cols_l):
    #         print(f"\nA[{i}][{j}] = {A[i][j].tolist()}")


    # # #--------  Step 6:
    tr = compute_tr(pk)
    # print(f"\ntr : {tr.hex()}") 


    # # #--------  Step 7:
    mu = compute_mu(tr, M_prime)
    # print(f"\nmu : {mu.hex()}") 


    # # #--------  Step 8:
    v_c = SampleInBall(c_h)
    # print(f"\nv_c : {v_c}") 


    # # #--------  Step 9:
    w_approx = compute_w_approx(A, z, v_c, t1)
    # for i, poly in enumerate(w_approx):
    #     print(f"\nw_approx[{i}] = [{', '.join(map(str, poly))}]")


    # # #--------  Step 10 & 11:
    w1 = []
    for i in range(len(h)):  #
        w1.append(use_hint(h[i], w_approx[i]))
    # for i, poly in enumerate(w1):
    #     print(f"w1[{i}] = {poly}")


    # # #--------  Step 12:
    w1_encoded = w1Encode(w1)
    # print(f"\nw1_enc : {w1_encoded.hex()}") 

    c_h_star = compute_commit_hash(mu, w1_encoded)
    # print(f"\nc_h_star : {c_h_star.hex()}")


    # # #--------  Step 13:
    ch_chstar_check = (c_h == c_h_star)
    return (compute_infinity_norm(z) < gamma1 - beta) and (ch_chstar_check)

