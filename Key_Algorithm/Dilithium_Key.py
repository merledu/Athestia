import math
import random
import numpy as np

from Crypto.Random import random
from Crypto.Hash import SHAKE256
from Crypto.Hash import SHAKE128


#---------------------------------------------------- PARAMETERS ----------------------------------------------------#
q = 8380417
rows_k = 8
cols_l = 7
coefficients_per_polynomial = 256
eta = 2
η = 2
d = 13


#---------------------------------------------------- FUNCTIONS ----------------------------------------------------#
def IntegerToBytes(x, α):
    y = [0] * α
    x_prime = x

    for i in range(α):
        y[i] = x_prime % 256
        x_prime = x_prime // 256
    return bytearray(y)


def bits_to_bytes(y):                                                       
    α = len(y)
    z = [0] * math.ceil(α / 8)   #The byte string has a length of [α/8⌉, math.ceil() method rounds a number to the nearest integer

    for i in range(α):
        z[i // 8] += y[i] * (2 ** (i % 8))   #Adds the bit y[i] to the appropriate position in the byte string z. The byte index is ⌊i/8⌋, 
                                             #and y[i] is multiplied by 2^(i mod 8) to shift the bit into the correct position within the byte.
    return bytearray(z) 


def IntegerToBits(x, α):
    x_prime = x
    y = [0] * α 

    for i in range(α):
        y[i] = x_prime % 2  #This operation extracts the least significant bit (LSB) of x. Modulo gives remainder
        x_prime = x_prime // 2    #This operation effectively moves to the next bit in x. (equivalent to a right shift). Division gives quotient 
    return y


def BitsToInteger(y, α):
    x = 0
    for i in range(1, α+1):
        x = (2*x) + y[α - i]  # Access the bit in little-endian order
    return x


def bitlen(x):     # Calculate the bit length of a positive integer x using a loop
    length = 0
    while x > 0:
        x = x // 2
        length += 1
    return length


#---------------------------------------------------- STEP 3 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
"""
This algorithm convert byte strings into specific coefficients.
It takes three bytes as input and generates an integer within the range {0,1,2,…,q−1} 
"""
def CoefFromThreeBytes(b0, b1, b2):
    b2_prime = b2
    if b2_prime > 127: #If b2 is greater than 127, it means the highest bit (the 8th bit) is 1.
        b2_prime -= 128   #Set the top bit of b2 to zero, value now fits within the lower 7 bits.

    z = ((2**16) * b2_prime) + ((2**8) * b1) + b0  # The three bytes are combined to form a single integer z. 
                                         #The first byte b2 is shifted(left) by 16 bits, the second byte b1 by 8 bits, 
                                         #and the third byte b0 is added directly. This creates a 24-bit integer from the three bytes.

    if z < q:  #If the resulting integer z is less than the modulus q
        # print(f"Coefficient: {z}")
        return z
    else:
        return None


"""
This algorithm samples a polynomial a from a set Tq using a pseudorandom procedure. 
The polynomial is generated in a domain where it can be efficiently processed using the Number Theoretic Transform (NTT).
"""
def RejNTTPoly(rho):                                                    
    a = [0] * 256
    j = 0    #used to iterate through the coefficients of the polynomial.

    shake = SHAKE128.new()
    shake.update(rho)
    
    while j < 256:
        output = shake.read(3) 
        a[j] = CoefFromThreeBytes(output[0], output[1], output[2])

        if a[j] is not None:
            j += 1

    # print("\nOutput of RejNTTPoly:", a)
    return a


#----------------------------------- ExpandA -----------------------------------#
"""
This algorithm generates a matrix A of polynomials, where each polynomial is sampled using the RejNTTPoly function. 
"""
def ExpandA(ρ):  
    A = np.zeros((rows_k, cols_l, 256), dtype=np.int32) 
    for r in range(rows_k):
        for s in range(cols_l):
            rho_concat = ρ + IntegerToBytes(s, 1) + IntegerToBytes(r, 1)
            A[r][s] = RejNTTPoly(rho_concat)
    return A


#---------------------------------------------------- STEP 4 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
"""
This algorithm takes a single integer b (ranging from 0 to 15, i.e., a "half-byte") 
and generates an element from the set {−η,−η+1,…,η}
"""
def CoefFromHalfByte(b):                                      
    if eta == 2 and b < 15:
        return 2 - (b % 5)   #The modulus operation ensures that the result wraps around within eta range.
    if eta == 4 and b < 9:
        return 4 - b
    return None


"""
This algorithm samples a polynomial a with coefficients bounded within the range [−η,η]. 
"""
def RejBoundedPoly(rho_p):
    j = 0     #used to iterate through the coefficients of the polynomial.
    a = [0] * 256

    shake = SHAKE256.new()
    shake.update(rho_p)
    
    while j < 256:
        z = shake.read(1)
        z_int = z[0]
        z0 = CoefFromHalfByte(z_int % 16)    #Extract the lower half-byte (4 bits)
        # print(f"Coefficient z0: {z0}")
        z1 = CoefFromHalfByte(z_int // 16)   #Extract the upper half-byte (remaining 4 bits)
      
        if z0 is not None:
            a[j] = z0
            j += 1

        if z1 is not None and j < 256:
            a[j] = z1
            j += 1

    # print("\nOutput of RejBoundedPoly:", a)
    return a


#----------------------------------- ExpandS -----------------------------------#
"""
This algorithm generates two vectors s1 and s2 of polynomials, 
each with coefficients in the range [−η,η].
"""
def ExpandS(ρ_prime):
    s1 = []
    s2 = []

    for r in range(cols_l):
        s1.append(RejBoundedPoly(ρ_prime + IntegerToBytes(r, 2)))

    for r in range(rows_k):
        s2.append(RejBoundedPoly(ρ_prime + IntegerToBytes(r + cols_l, 2)))
    
    return (s1, s2)


#---------------------------------------------------- STEP 5 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
zetas = [
    0, 4808194, 3765607, 3761513, 5178923, 5496691, 5234739, 5178987,
    7778734, 3542485, 2682288, 2129892, 3764867, 7375178, 557458, 7159240,
    5010068, 4317364, 2663378, 6705802, 4855975, 7946292, 676590, 7044481,
    5152541, 1714295, 2453983, 1460718, 7737789, 4795319, 2815639, 2283733,
    3602218, 3182878, 2740543, 4793971, 5269599, 2101410, 3704823, 1159875,
    394148, 928749, 1095468, 4874037, 2071829, 4361428, 3241972, 2156050,
    3415069, 1759347, 7562881, 4805951, 3756790, 6444618, 6663429, 4430364,
    5483103, 3192354, 556856, 3870317, 2917338, 1853806, 3345963, 1858416,
    3073009, 1277625, 5744944, 3852015, 4183372, 5157610, 5258977, 8106357,
    2508980, 2028118, 1937570, 4564692, 2811291, 5396636, 7270901, 4158088,
    1528066, 482649, 1148858, 5418153, 7814814, 169688, 2462444, 5046034,
    4213992, 4892034, 1987814, 5183169, 1736313, 235407, 5130263, 3258457,
    5801164, 1787943, 5989328, 6125690, 3482206, 4197502, 7080401, 6018354,
    7062739, 2461387, 3035980, 621164, 3901472, 7153756, 2925816, 3374250,
    1356448, 5604662, 2683270, 5601629, 4912752, 2312838, 7727142, 7921254,
    348812, 8052569, 1011223, 6026202, 4561790, 6458164, 6143691, 1744507,
    1753, 6444997, 5720892, 6924527, 2660408, 6600190, 8321269, 2772600,
    1182243, 87208, 636927, 4415111, 4423672, 6084020, 5095502, 4663471,
    8352605, 822541, 1009365, 5926272, 6400920, 1596822, 4423473, 4620952,
    6695264, 4969849, 2678278, 4611469, 4829411, 635956, 8129971, 5925040,
    4234153, 6607829, 2192938, 6653329, 2387513, 4768667, 8111961, 5199961,
    3747250, 2296099, 1239911, 4541938, 3195676, 2642980, 1254190, 8368000,
    2998219, 141835, 8291116, 2513018, 7025525, 613238, 7070156, 6161950,
    7921677, 6458423, 4040196, 4908348, 2039144, 6500539, 7561656, 6201452,
    6757063, 2105286, 6006015, 6346610, 586241, 7200804, 527981, 5637006,
    6903432, 1994046, 2491325, 6987258, 507927, 7192532, 7655613, 6545891,
    5346675, 8041997, 2647994, 3009748, 5767564, 4148469, 749577, 4357667,
    3980599, 2569011, 6764887, 1723229, 1665318, 2028038, 1163598, 5011144,
    3994671, 8368538, 7009900, 3020393, 3363542, 214880, 545376, 7609976,
    3105558, 7277073, 508145, 7826699, 860144, 3430436, 140244, 6866265,
    6195333, 3123762, 2358373, 6187330, 5365997, 6663603, 2926054, 7987710,
    8077412, 3531229, 4405932, 4606686, 1900052, 7598542, 1054478, 7648983
]


def postprocess_modular(values):
    return [x if x < q//2 else x - q for x in values]


def NTT(w):
    w_hat = w.copy()
    for j in range(256):
        w_hat[j] = w[j]

    m = 0
    length = 128
    
    while length >= 1:
        start = 0
        while start < 256:
            m += 1
            z = zetas[m]
            
            for j in range(start, start + length):
                # t = montgomery_reduce(z * w_hat[j + length])
                t = (z * w_hat[j + length]) % q
                w_hat[j + length] = (w_hat[j] - t) % q
                w_hat[j] = (w_hat[j] + t) % q
            
            start += 2 * length
        
        length //= 2  # Halve the length for the next iteration

    return w_hat


def NTT_inverse(w_hat):
    w = w_hat.copy()
    for j in range(256):
        w[j] = w_hat[j]

    m = 256
    length = 1

    while length < 256:
        start = 0
        
        while start < 256:
            m -= 1
            z = -zetas[m]

            for j in range(start, start + length):
                t = w[j]  
                w[j] = (t + w[j + length]) % q  
                w[j + length] = (t - w[j + length]) % q  
                # w[j + length] = montgomery_reduce(z * w[j + length])
                w[j + length] = (z * w[j + length]) % q
            
            start += 2 * length  
            
        length *= 2  
    
    f = 8347681  # 256^(-1) mod q

    for j in range(256):
        w[j] = (f * w[j]) % q  

    return w 


#----------------------------------- Compute_t -----------------------------------#
def compute_t(A_ntt, s1_ntt, s2):
    t_ntt = []
    for _ in range(rows_k):
        vector_ntt_t = [0] * coefficients_per_polynomial
        t_ntt.append(vector_ntt_t)

    t = []
    for _ in range(rows_k):
        vector_invntt_t = [0] * coefficients_per_polynomial
        t.append(vector_invntt_t)

    for i in range(rows_k):
        for j in range(cols_l):
            t_ntt[i] += A_ntt[i][j] * s1_ntt[j]

    for i in range(rows_k):
        t[i] = NTT_inverse(t_ntt[i])

    for i in range(8):
        t[i] += s2[i]

    return t


#---------------------------------------------------- STEP 6 & 7----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
"""
This algorithm decompose an integer r into two smaller integers r1 and r0.
r1 is essentially the higher bits of r, and r0 is the lower d bits.
"""
def power2round(t):
    t_mod_q = t % q    #This ensures that t is reduced to a value within the range [0, q-1].

    t0 = t_mod_q % (2**d)     #ensure that t0 represents the lower d bits of t

    # if t_mod_2d >= 2**(d-1):    # If this value exceeds it is adjusted by subtracting to bring it into the desired range.
    #     t_mod_2d -= 2**d

    t1 = (t_mod_q - t0) // (2**d)  # This extracts the higher bits of t by removing the lower d bits (t0)
    # t0 = t_mod_2d

    return t1, t0


#----------------------------------- Compute_t1, t0 -----------------------------------#
t1 = []
for _ in range(rows_k):
    vectort1 = [0] * coefficients_per_polynomial
    t1.append(vectort1)

t0 = []
for _ in range(rows_k):
    vectort0 = [0] * coefficients_per_polynomial
    t0.append(vectort0)


#---------------------------------------------------- STEP 8 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
"""
This algorithm encodes a polynomial w into a byte string, 
assuming that each coefficient wi of the polynomial is in the range [0,b].
"""
def simple_bit_pack(w, b):
    z = []     # To store the bit representation of the polynomial coefficients.
    for i in range(256):
        z += IntegerToBits(w[i], bitlen(b))

    return bits_to_bytes(z)


# #----------------------------------- pk_encode -----------------------------------#
"""
The purpose of the pkEncode algorithm is to encode a public key into a byte string format
"""
def pk_encode(rho, t1):
    pk = rho

    y = bitlen(q - 1)
    b = (2 ** (y - d)) - 1

    for i in range(rows_k):
        pk = pk + simple_bit_pack(t1[i], b)

    return pk


# #---------------------------------------------------- STEP 9 ----------------------------------------------------#
#----------------------------------- Compute_tr -----------------------------------#
def compute_tr(pk):
    shake = SHAKE256.new()
    shake.update(pk)  
    tr = shake.read(64)  # 512 bits = 64 bytes
    return tr


#---------------------------------------------------- STEP 9 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
"""
This algorithm encodes a polynomial w into a byte string, 
assuming that each coefficient wi of the polynomial is in the range [−a,b].
"""
def BitPack(w, a, b):
    z = []

    for i in range(256):
        z += IntegerToBits(b - w[i], bitlen(a+b))   #subtracts each coefficient wi from b, converting it to a non-negative integer in the range [0,a+b]

    byte_output = bits_to_bytes(z)
    return byte_output


# #----------------------------------- sk_encode -----------------------------------#
"""
The skEncode algorithm encodes a secret key into a byte string.
"""
def skEncode(rho, K, tr, s1, s2, t0):
    sk = rho + K + tr

    for i in range(cols_l):
        sk += BitPack(s1[i], η, η)

    for i in range(rows_k):
        sk += BitPack(s2[i], η, η)

    for i in range(rows_k):
        sk += BitPack(t0[i], 2**(d-1) -1, 2**(d-1))

    return sk


#---------------------------------------------------- MAIN FUNCTION ----------------------------------------------------#
def KeyGen():
    # secure_random = random.StrongRandom()
    # seed_length = 32  
    # random_no = secure_random.getrandbits(seed_length * 8)   #32 * 8 = 256 bits

    random_no = 30
    # print(random_no)

    random_bytes = random_no.to_bytes((random_no.bit_length() + 7) // 8, byteorder='big')

    shake = SHAKE256.new()
    shake.update(random_bytes)
    ξ = shake.read(32)  #256 bits = 32 bytes

    # ξ = IntegerToBytes(random_no, seed_length)
    # print(ξ)

    if ξ is None:
        return None  

    # return ξ

    # return KeyGen_internal(ξ)
    
    pk, sk = KeyGen_internal(ξ)
    return pk, sk
    
# ξ = KeyGen()


#---------------------------------------------------- KeyGen_internal ----------------------------------------------------#
def KeyGen_internal(ξ):
    #--------  Step 1: (rho, rho', K) ← H(ξ || IntegerToBytes(k, 1) || IntegerToBytes(l, 1), 128)
    shake = SHAKE256.new()
    shake.update(ξ + IntegerToBytes(rows_k, 1) + IntegerToBytes(cols_l, 1))
    output = shake.read(128)  # 1024 bits = 128 bytes

    rho = output[:32]       # First 256 bits
    rho0 = output[32:96]    # Next 512 bits (64 bytes)
    K_bytes = output[96:]   # Last 256 bits

    # print(f"\nρ : {rho}")
    # print(f"\nρ' : {rho0}")
    # print(f"\nK : {K_bytes}")


    #-------- Step 2: Expand A ← ExpandA(rho)
    # a = RejNTTPoly(rho)
    A = ExpandA(rho)
    # for i in range(rows_k):
    #     for j in range(cols_l):
    #         print(f"\nA[{i}][{j}] = {A[i][j].tolist()}")


    #-------- Step 3: (s1, s2) ← ExpandS(rho')
    # a = RejBoundedPoly(rho0)
    s1, s2 = ExpandS(rho0)
    # print("Vector s1:")
    # for i in range(len(s1)):
    #     print(f"\ns1[{i}] = {s1[i]}")

    # print("Vector s2:")
    # for i in range(len(s2)):
    #     print(f"\ns2[{i}] = {s2[i]}")


    #-------- Step 4: t ← NTT−1(A * NTT(s1)) + s2
    A_ntt = np.zeros((rows_k, cols_l, coefficients_per_polynomial), dtype=int)
    for i in range(rows_k):
        for j in range(cols_l):
            A_ntt[i, j] = NTT(A[i, j].tolist())

    # for i in range(rows_k):
    #     for j in range(cols_l):
    #         print(f"\nA_NTT[{i}][{j}] = {A_ntt[i][j].tolist()}")

    A_invntt = np.zeros((rows_k, cols_l, coefficients_per_polynomial), dtype=int)
    for i in range(rows_k):
        for j in range(cols_l):
            A_invntt[i, j] = NTT_inverse(A_ntt[i, j].tolist())

    # for i in range(rows_k):
    #     for j in range(cols_l):
    #         print(f"\nA_InvNTT[{i}][{j}] = {A_invntt[i][j].tolist()}")

    s1_ntt = []
    for i in range(len(s1)):
        s1_ntt.append(NTT(s1[i]))

    # for i in range(len(s1_ntt)):
    #     print(f"\ns1_ntt[{i}] = {s1_ntt[i]}")

    s1_invntt = []
    for i in range(len(s1_ntt)):
        s1_invntt.append(postprocess_modular(NTT_inverse(s1_ntt[i])))

    # for i in range(len(s1_invntt)):
    #     print(f"\ns1_invntt[{i}] = {s1_invntt[i]}")

    t = compute_t(A_ntt, s1_ntt, s2)
    # for i in range(len(t)):
    #     print(f"\nt[{i}] = {', '.join(map(str, t[i]))}")


    #-------- Step 5: (t1, t0) ← Power2Round(t)
    for i in range(len(t)):
        for j in range(coefficients_per_polynomial):
            t1_coef, t0_coef = power2round(t[i][j])
            t1[i][j] = t1_coef
            t0[i][j] = t0_coef
    
    # for i in range(len(t1)):
    #     print(f"\nt1[{i}] = [{', '.join(map(str, t1[i]))}]")

    # for i in range(len(t0)):
    #     print(f"\nt0[{i}] = [{', '.join(map(str, t0[i]))}]")


    #-------- Step 6: pk ← pkEncode(rho, t1)
    pk = pk_encode(rho, t1)
    # print(f"\npk : {pk}") 

    expected_length = 32 + 32 * rows_k * (bitlen(q - 1) - d)
    actual_length = len(pk)
    # print("Expected Length:", expected_length, "bytes")
    # print("Actual Length:", actual_length, "bytes")
    # print("Verification:", "Correct" if expected_length == actual_length else "Incorrect")


    #-------- Step 7: tr ← H(pk, 64)
    tr = compute_tr(pk)

    # print(f"\ntr : {tr}") 
    # print(f"\ntr : {len(tr)}") 


    #-------- Step 8: sk ← skEncode(rho, K, tr, s1, s2, t0)
    sk = skEncode(rho, K_bytes, tr, s1, s2, t0)
    # print(f"\nsk : {sk}")   

    expected_length = 32 + 32 + 64 + 32 * ((rows_k + cols_l) * bitlen(2 * eta) + d * rows_k)
    actual_length = len(sk)
    # print("Expected Length:", expected_length, "bytes")
    # print("Actual Length:", actual_length, "bytes")
    # print("Verification:", "Correct" if expected_length == actual_length else "Incorrect")  


    #-------- Step 9: Return (pk, sk)

    return pk, sk

# KeyGen()
pk, sk = KeyGen()
# print("Public Key:", pk)
# print("\nPrivate Key:", sk)
