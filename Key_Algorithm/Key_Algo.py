import sys
import math
import random
import numpy as np

sys.path.append('/home/hafsa/Athestia/pycryptodome/lib/Crypto/Hash')

from SHAKE256 import SHAKE256_XOF
from SHAKE128 import SHAKE128_XOF


#---------------------------------------------------- PARAMETERS ----------------------------------------------------#
q = 8380417
rows_k = 8
cols_l = 7
coefficients_per_polynomial = 256
eta = 2
η = 2
d = 13


#---------------------------------------------------- FUNCTIONS ----------------------------------------------------#
"""
This algorithm converts a nonnegative integer x into its binary representation 
as a bit string of length α. The result is presented in little-endian order
"""
def IntegerToBits(x, α):
    y = []

    for i in range(α):
        y.append(x % 2)   #This operation extracts the least significant bit (LSB) of x.
        x = x // 2     #This operation effectively moves to the next bit in x. (equivalent to a right shift). 
    return y


"""
This algorithm converts a bit string y of length c into a byte string z.
"""
def bits_to_bytes(y):                                                       
    c = len(y)
    z = [0] * math.ceil(c / 8)   #The byte string has a length of ⌈c/8⌉

    for i in range(c):
        z[i // 8] += y[i] * (2 ** (i % 8))   #Adds the bit y[i] to the appropriate position in the byte string z. The byte index is ⌊i/8⌋, 
                                             #and y[i] is multiplied by 2^(i mod 8) to shift the bit into the correct position within the byte.
    return bytes(z)  


#---------------------------------------------------- STEP 1 ----------------------------------------------------#
random_int = 30
# random_int = random.randint(1, 100)
# print(f"Random Int: {random_int}")

random_bytes = random_int.to_bytes((random_int.bit_length() + 7) // 8, byteorder='big')

shake = SHAKE256_XOF()
shake.update(random_bytes)
zeta_bytes = shake.read(32)  #256 bits = 32 bytes

zeta = [int(bit) for byte in zeta_bytes for bit in format(byte, '08b')]
# print(f"\nζ : {zeta}")


#---------------------------------------------------- STEP 2 ----------------------------------------------------#
shake.new(zeta_bytes)
output = shake.read(128)  # 1024 bits = 128 bytes

rho = output[:32]       # First 256 bits
rho0 = output[32:96]    # Next 512 bits (64 bytes)
K_bytes = output[96:]   # Last 256 bits

ρ = [int(bit) for byte in rho for bit in format(byte, '08b')]
# print(f"\nρ : {ρ}")
ρ_prime = [int(bit) for byte in rho0 for bit in format(byte, '08b')]
# print(f"\nρ' : {ρ_prime}")
K = [int(bit) for byte in K_bytes for bit in format(byte, '08b')]
# print(f"\nK : {K}")


#---------------------------------------------------- STEP 3 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
"""
This algorithm convert byte strings into specific coefficients.
It takes three bytes as input and generates an integer within the range {0,1,2,…,q−1} 
"""
def CoefFromThreeBytes(b0, b1, b2):
    if b2 > 127: #If b2 is greater than 127, it means the highest bit (the 8th bit) is 1.
        b2 -= 128   #Set the top bit of b2 to zero, value now fits within the lower 7 bits.

    z = (2**16) * b2 + (2**8) * b1 + b0  # The three bytes are combined to form a single integer z. 
                                         #The first byte b2 is shifted by 16 bits, the second byte b1 by 8 bits, 
                                         #and the third byte b0 is added directly. This creates a 24-bit integer from the three bytes.

    if z < q:  #If the resulting integer z is less than the modulus q
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
    c = 0    #used to track the position within the seed ρ when extracting random bits

    shake = SHAKE128_XOF()
    shake.update(bits_to_bytes(rho))
    output = shake.read(256*3*2)  # Reading enough bytes for multiple iterations
    
    while j < 256:
        coef = CoefFromThreeBytes(output[c], output[c + 1], output[c + 2])
        c += 3

        if coef is not None:
            a[j] = coef
            j += 1

    return a


#----------------------------------- ExpandA -----------------------------------#
"""
This algorithm generates a matrix A of polynomials, where each polynomial is sampled using the RejNTTPoly function. 
"""
def ExpandA(ρ):  
    A = np.zeros((rows_k, cols_l, 256), dtype=np.int32) 
    for r in range(rows_k):
        for s in range(cols_l):
            rho_concat = ρ + IntegerToBits(s, 8) + IntegerToBits(r, 8)
            A[r][s] = RejNTTPoly(rho_concat)
    return A

A = ExpandA(ρ)

# for i in range(rows_k):
#     for j in range(cols_l):
#         print(f"\nA[{i}][{j}] = {A[i][j].tolist()}")


#---------------------------------------------------- STEP 4 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
"""
This algorithm takes a single integer b (ranging from 0 to 15, i.e., a "half-byte") 
and generates an element from the set {−η,−η+1,…,η}
"""
def CoefFromHalfByte(b):                                      
    if eta == 2 and b < 15:
        return 2 - (b % 5)   #The modulus operation ensures that the result wraps around within this range.
    else:
        return None


"""
This algorithm samples a polynomial a with coefficients bounded within the range [−η,η]. 
"""
def RejBoundedPoly(rho_p):
    j = 0     #used to iterate through the coefficients of the polynomial.
    c = 0    #used to track the position within the seed ρ when extracting random bits.
    a = [0] * 256

    shake = SHAKE128_XOF()
    shake.update(bits_to_bytes(rho_p))
    output = shake.read(256)  # Reading enough bytes for multiple iterations
    
    while j < 256:
        z = output[c]

        z0 = CoefFromHalfByte(z % 16)    #Extract the lower half-byte (4 bits)
        z1 = CoefFromHalfByte(z // 16)   #Extract the upper half-byte (remaining 4 bits)
      
        if z0 is not None:
            a[j] = z0
            j += 1

        if z1 is not None and j < 256:
            a[j] = z1
            j += 1

        c += 1
    
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
        s1.append(RejBoundedPoly(ρ_prime + IntegerToBits(r, 16)))

    for r in range(rows_k):
        s2.append(RejBoundedPoly(ρ_prime + IntegerToBits(r + cols_l, 16)))
    
    return (s1, s2)

s1, s2 = ExpandS(ρ_prime)

# print("Vector s1:")
# for i in range(len(s1)):
#     print(f"\ns1[{i}] = {s1[i]}")

# print("Vector s2:")
# for i in range(len(s2)):
#     print(f"\ns2[{i}] = {s2[i]}")


#---------------------------------------------------- STEP 5 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
"""
The Number-Theoretic Transform (NTT) is a mathematical transformation used to speed up polynomial multiplications.
It operates in modular arithmetic, and the result is a polynomial in the transformed domain.
"""
def postprocess_modular(values):
    return [x if x < q//2 else x - q for x in values]

def bit_reversal(i, k):
    bin_i = bin(i & (2 ** k - 1))[2:].zfill(k)
    return int(bin_i[::-1], 2)

zeta = [pow(1753, bit_reversal(i, 8), q) for i in range(256)] 


def ntt(w1):
    w_hat = w1.copy()

    k = 0
    length = 128
    
    while length >= 1:
        start = 0
        
        while start < 256:
            k += 1
            zeta_val = zeta[k] % q # ζ^brv(k) mod q
            
            for j in range(start, start + length):
                t = (zeta_val * w_hat[j + length]) % q
                w_hat[j + length] = (w_hat[j] - t) % q
                w_hat[j] = (w_hat[j] + t) % q
            
            start += 2 * length
        
        length = length // 2
    
    return w_hat


"""
The Inverse Number-Theoretic Transform (NTT−1) computes the inverse of the NTT, 
which transforms the polynomial back from the transformed domain to the original domain
"""
def ntt_inverse(w_hat):
    w = w_hat.copy()

    k = 256
    length = 1
    
    while length < 256:
        start = 0
        
        while start < 256:
            k -= 1
            zeta_val = (-zeta[k]) % q  # -ζ^brv(k) mod q
            
            for j in range(start, start + length):
                t = w[j]
                w[j] = (t + w[j + length]) % q
                w[j + length] = (t - w[j + length]) % q
                w[j + length] = (zeta_val * w[j + length]) % q
            
            start += 2 * length
        
        length *= 2

    f = 8347681  # Modular inverse of 256 mod q
    for j in range(256):
        w[j] = (f * w[j]) % q
    
    return w

A_ntt = np.zeros((rows_k, cols_l, coefficients_per_polynomial), dtype=int)
for i in range(rows_k):
    for j in range(cols_l):
        A_ntt[i, j] = ntt(A[i, j].tolist())

# for i in range(rows_k):
#     for j in range(cols_l):
#         print(f"\nA_NTT[{i}][{j}] = {A_ntt[i][j].tolist()}")

A_invntt = np.zeros((rows_k, cols_l, coefficients_per_polynomial), dtype=int)
for i in range(rows_k):
    for j in range(cols_l):
        A_invntt[i, j] = ntt_inverse(A_ntt[i, j].tolist())

# for i in range(rows_k):
#     for j in range(cols_l):
#         print(f"\nA_InvNTT[{i}][{j}] = {A_invntt[i][j].tolist()}")

s1_ntt = []
for i in range(len(s1)):
    s1_ntt.append(ntt(s1[i]))

# for i in range(len(s1_ntt)):
#     print(f"\ns1_ntt[{i}] = {s1_ntt[i]}")

s1_invntt = []
for i in range(len(s1_ntt)):
    s1_invntt.append(postprocess_modular(ntt_inverse(s1_ntt[i])))

# for i in range(len(s1_invntt)):
#     print(f"\ns1_invntt[{i}] = {s1_invntt[i]}")


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
        t[i] = ntt_inverse(t_ntt[i])

    for i in range(8):
        t[i] += s2[i]

    return t

t = compute_t(A_ntt, s1_ntt, s2)

# for i in range(len(t)):
#     print(f"\nt[{i}] = {', '.join(map(str, t[i]))}")


#---------------------------------------------------- STEP 6 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
"""
This algorithm decompose an integer r into two smaller integers r1 and r0
r1 is essentially the higher bits of r, and r0 is the lower d bits.
"""
def power2round(t):
    t_mod_q = t % q    #This ensures that t is reduced to a value within the range [0, q-1].

    t_mod_2d = t_mod_q % (2**d)     #ensure that t0 represents the lower d bits of t

    if t_mod_2d >= 2**(d-1):    # If this value exceeds it is adjusted by subtracting to bring it into the desired range.
        t_mod_2d -= 2**d

    t1 = (t_mod_q - t_mod_2d) // (2**d)  # This extracts the higher bits of t by removing the lower d bits (t0)
    t0 = t_mod_2d

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

for i in range(len(t)):
    for j in range(coefficients_per_polynomial):
        t1_coef, t0_coef = power2round(t[i][j])
        t1[i][j] = t1_coef
        t0[i][j] = t0_coef

# for i in range(len(t1)):
#     print(f"\nt1[{i}] = [{', '.join(map(str, t1[i]))}]")

# for i in range(len(t0)):
#     print(f"\nt0[{i}] = [{', '.join(map(str, t0[i]))}]")


#---------------------------------------------------- STEP 7 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
"""
This algorithm encodes a polynomial w into a byte string, 
assuming that each coefficient wi of the polynomial is in the range [0,b].
"""
def simple_bit_pack(w, b):
    z = []     # To store the bit representation of the polynomial coefficients.
    for i in range(256):
        z = z + IntegerToBits(w[i], b)

    return bits_to_bytes(z)


#----------------------------------- pk_encode -----------------------------------#
"""
The purpose of the pkEncode algorithm is to encode a public key  into a byte string format
"""
def pk_encode(rho, t1):
    pk = bits_to_bytes(rho)

    bitlen = math.ceil(math.log2(q - 1)) - d

    for i in range(rows_k):
        pk = pk + simple_bit_pack(t1[i], bitlen)

    return pk

pk = pk_encode(ρ, t1)
# print(f"\npk : {pk}") 

# expected_length = 2592  # From the calculation above
# actual_length = len(pk)
# print("Expected Length:", expected_length, "bytes")
# print("Actual Length:", actual_length, "bytes")
# print("Verification:", "Correct" if expected_length == actual_length else "Incorrect")

# #---------------------------------------------------- STEP 8 ----------------------------------------------------#
# #----------------------------------- FUNCTIONS -----------------------------------#
"""
This algorithm converts a byte string z of length d into a bit string y.
"""
def bytes_to_bits(z):
    y = []
    d = len(z)

    for i in range(d):
        for j in range(rows_k):   #For each byte, loop through its 8 bits
            y.append(z[i] % 2)  # Get the least significant bit
            z[i] //= 2  #Effectively moving to the next bit.

    return y


#----------------------------------- Compute_tr -----------------------------------#
def compute_tr(pk):
    bit_string = bytes_to_bits(list(pk))

    shake = SHAKE256_XOF()
    shake.new(bits_to_bytes(bit_string))  
    # shake.new(bytes_to_bits(list(pk)))
    tr = shake.read(64)  # 512 bits = 64 bytes
    tr_bits = bytes_to_bits(list(tr))
    # return tr
    return tr_bits

tr = compute_tr(pk)
# print(f"\ntr : {tr}") 
# print(f"\ntr : {len(tr)}") 


#---------------------------------------------------- STEP 9 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
"""
This algorithm encodes a polynomial w into a byte string, 
assuming that each coefficient wi of the polynomial is in the range [−a,b].
"""
def BitPack(w, a, b):
    z = []
    bitlen = math.ceil(math.log2(a + b))  # Compute bit length for (a + b)
    for i in range(256):
        z += IntegerToBits(b - w[i], bitlen)   #subtracts each coefficient wi from b, converting it to a non-negative integer in the range [0,a+b]

    byte_output = bits_to_bytes(z)
    # print(f"BitPack output length: {len(byte_output)} bytes")  # Add this line to log the output length
    return byte_output


#----------------------------------- sk_encode -----------------------------------#
"""
The skEncode algorithm encodes a secret key into a byte string.
"""
def skEncode(p, K, tr, s1, s2, t0):
    sk = bits_to_bytes(p) + bits_to_bytes(K) + bits_to_bytes(tr)

    for i in range(cols_l):
        sk += BitPack(s1[i], η, η)

    for i in range(rows_k):
        sk += BitPack(s2[i], η, η)

    for i in range(rows_k):
        sk += BitPack(t0[i], 2**(d-1) -1, 2**(d-1))

    return sk

sk = skEncode(ρ, K, tr, s1, s2, t0)
print(f"\nsk : {sk}") 



