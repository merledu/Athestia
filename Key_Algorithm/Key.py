import sys
import random
import numpy as np

sys.path.append('/home/hafsa/Dilithium/pycryptodome/lib/Crypto/Hash')
sys.path.append('/home/hafsa/Dilithium/pycryptodome/lib')

from SHAKE256 import SHAKE256_XOF
from Crypto.Cipher import AES


#---------------------------------------------------- STEP 1 ----------------------------------------------------#
random_int = 30
# random_int = random.randint(1, 100)
# print(f"Random Int: {random_int}")

random_bytes = random_int.to_bytes((random_int.bit_length() + 7) // 8, byteorder='big')

shake = SHAKE256_XOF()
shake.update(random_bytes)
zeta_bytes = shake.read(32)  #256 bits = 32 bytes

# zeta = ''
# for byte in zeta_bytes:
#     zeta_binary = format(byte, '08b')
#     zeta += zeta_binary
# print(f"ζ: {zeta}")


#---------------------------------------------------- STEP 2 ----------------------------------------------------#
shake.new(zeta_bytes)
output = shake.read(128)  # 1024 bits = 128 bytes

rho = output[:32]       # First 256 bits
rho0 = output[32:96]    # Next 512 bits (64 bytes)
K = output[96:]         # Last 256 bits

ρ = ''.join(format(byte, '08b') for byte in rho)
# print(f"\nρ : {ρ}")
# print("ρ':", ''.join(format(byte, '08b') for byte in rho0))
K = ''.join(format(byte, '08b') for byte in K)
# print("K : {K}")


#---------------------------------------------------- STEP 3 ----------------------------------------------------#
rows, cols = 8, 7
coefficients_per_polynomial = 256

def expandA(A, rho):
    for i in range(rows):
        for j in range(cols):
            nonce_int = 256 * i + j
            nonce_bytes = nonce_int.to_bytes(12, byteorder='little')  
            
            aes = AES.new(rho, AES.MODE_CTR, nonce=nonce_bytes)
            stream = aes.encrypt(b'\x00' * 768) 
            # print(f"nonce_int: {nonce_int}, nonce_bytes: {nonce_bytes}, stream: {stream}")

            for k in range(coefficients_per_polynomial): # 0 to 255
                start_ind = k * 3
                block = stream[start_ind:start_ind + 3]  #246 blocks
  
                block = bytes([block[0], block[1], block[2] & 0x7F])  #(01111111 in binary) that has its highest bit set to 0

                combined_int = int.from_bytes(block, byteorder='little')

                if combined_int < 8380415:  # q-1 = 8380415
                    A[i, j, k] = combined_int


A = np.zeros((rows, cols, coefficients_per_polynomial), dtype=int)
expandA(A, rho)
for i in range(rows):
    for j in range(cols):
        print(f"\nA[{i}][{j}] = {A[i][j]}")


#---------------------- NTT ----------------------#
q = 8380416
root = 1753

# Function to bit-reverse the indices
def bit_reverse(value, bits):
    result = 0
    for i in range(bits):
        if value & (1 << i):
            result |= 1 << (bits - 1 - i)
    return result

# NTT function
def ntt(a, n, q, root):
    levels = n.bit_length() - 1
    a = [a[bit_reverse(i, levels)] for i in range(n)]  # Bit-reversal permutation

    length = 2
    while length <= n:
        half_length = length // 2
        table_step = n // length
        for i in range(0, n, length):
            k = 0
            for j in range(i, i + half_length):
                u = a[j]
                v = a[j + half_length] * pow(root, k, q) % q
                a[j] = (u + v) % q
                a[j + half_length] = (u - v) % q
                k += table_step
        length *= 2
    return a

# Function to apply NTT to the entire matrix
def apply_ntt_to_matrix(A, n, q, root):
    rows, cols = A.shape[:2]
    A_ntt = np.zeros((rows, cols, n), dtype=int)
    
    for i in range(rows):
        for j in range(cols):
            A_ntt[i, j] = ntt(list(A[i, j]), n, q, root)
    
    return A_ntt

# Apply NTT to the entire matrix
A_ntt = apply_ntt_to_matrix(A, coefficients_per_polynomial, q, root)

# Print the NTT of matrix A
# print("\nNTT of matrix A:")
# for i in range(rows):
#     for j in range(cols):
#         print(f"\nA_ntt[{i}][{j}] = {A_ntt[i][j]}")


# Inverse NTT function
def intt(a, n, q, root):
    inv_n = pow(n, q - 2, q)  # Modular multiplicative inverse of n under q
    a = ntt(a, n, q, pow(root, q-2, q))  # Apply NTT with inverse root of unity
    a = [x * inv_n % q for x in a]  # Scale by n^(-1)
    return a

    # Function to apply inverse NTT to the entire matrix
def apply_intt_to_matrix(A_ntt, n, q, root):
    rows, cols = A_ntt.shape[:2]
    A_original = np.zeros((rows, cols, n), dtype=int)
    
    for i in range(rows):
        for j in range(cols):
            A_original[i, j] = intt(list(A_ntt[i, j]), n, q, root)
    
    return A_original

    # Apply inverse NTT to get back the original matrix
A_original = apply_intt_to_matrix(A_ntt, coefficients_per_polynomial, q, root)

# Print the reconstructed original matrix A
# print("\nReconstructed original matrix A:")
# for i in range(rows):
#     for j in range(cols):
#         print(f"\nA_original[{i}][{j}] = {A_original[i][j]}")


#---------------------------------------------------- STEP 4 ----------------------------------------------------#
η = 2

s1 = []
for _ in range(cols):
    vectors1 = [0] * coefficients_per_polynomial
    s1.append(vectors1)

s2 = []
for _ in range(rows):
    vectors2 = [0] * coefficients_per_polynomial
    s2.append(vectors2)


def expandS1(s1, rho0):
    for i in range(cols):
        nonce_int = i
        nonce_bytes = nonce_int.to_bytes(12, byteorder='big')  
        
        aes = AES.new(rho0[:32], AES.MODE_CTR, nonce=nonce_bytes)
        stream = aes.encrypt(b'\x00' * 4) 
        # print(f"nonce_int: {nonce_int}, nonce_bytes: {nonce_bytes}, stream: {stream}")

        aes_binary = ''
        for byte in stream:
            binary = format(byte, '08b')
            aes_binary += binary
        # print(f"aes_binary: {aes_binary}")


        coefficients = []
        for _ in range(coefficients_per_polynomial // 2):
            lower_4_bits = aes_binary[-4:]
            upper_4_bits = aes_binary[:4]

            r1 = int(lower_4_bits, 2) % 5
            r2 = int(upper_4_bits, 2) % 5

            r1_int = η - r1
            r2_int = η - r2 

            coefficients.append(r1_int)
            coefficients.append(r2_int)
            
        s1[i] = coefficients


expandS1(s1, rho0)

# print("s1:")
# for i in s1:
#     print(i)


def expandS2(s2, rho0):
    for i in range(rows):
        nonce_int = i
        nonce_bytes = nonce_int.to_bytes(12, byteorder='big')  
        
        aes = AES.new(rho0[:32], AES.MODE_CTR, nonce=nonce_bytes)
        stream = aes.encrypt(b'\x00' * 4) 
        # print(f"nonce_int: {nonce_int}, nonce_bytes: {nonce_bytes}, stream: {stream}")

        aes_binary = ''
        for byte in stream:
            binary = format(byte, '08b')
            aes_binary += binary
        # print(f"aes_binary: {aes_binary}")


        coefficients = []
        for _ in range(coefficients_per_polynomial // 2):
            lower_4_bits = aes_binary[-4:]
            upper_4_bits = aes_binary[:4]

            r1 = int(lower_4_bits, 2) % 5
            r2 = int(upper_4_bits, 2) % 5

            r1_int = η - r1
            r2_int = η - r2

            coefficients.append(r1_int)
            coefficients.append(r2_int)
            
        s2[i] = coefficients


expandS2(s2, rho0)

# print("\ns2:")
# for i in s2:
#     print(i)


#---------------------------------------------------- STEP 5 ----------------------------------------------------#
t = []
for _ in range(rows):
    vectort = [0] * coefficients_per_polynomial
    t.append(vectort)

# print("\nt:")
# for i in t:
#     print(i)

def compute_t(A, s1, s2):
    for i in range(8):
        for j in range(7):
            t[i] += A[i][j] * s1[j]
        t[i] += s2[i]

compute_t(A, s1, s2)
# print("\nt:")
# for i in t:
#     print(i)


#---------------------------------------------------- STEP 6 ----------------------------------------------------#
t1 = []
for _ in range(rows):
    vectort1 = [0] * coefficients_per_polynomial
    t1.append(vectort1)

# print("\nt1:")
# for i in t1:
#     print(i)

t0 = []
for _ in range(rows):
    vectort0 = [0] * coefficients_per_polynomial
    t0.append(vectort0)

# print("\nt0:")
# for i in t0:
#     print(i)

d = 13

def power2round(t, d, q):
    t_mod_q = t % q

    t_mod_2d = t_mod_q % (2**d)

    t1 = (t_mod_q - t_mod_2d) // (2**d)
    t0 = t_mod_2d

    return t1, t0


for i in range(len(t)):
    for j in range(coefficients_per_polynomial):
        t1_coef, t0_coef = power2round(t[i][j], d, q)
        t1[i][j] = t1_coef
        t0[i][j] = t0_coef

# print("\nt1:")
# for i in t1:
#     print(i)

# print("\nt0:")
# for i in t0:
#     print(i)


#---------------------------------------------------- STEP 7 ----------------------------------------------------#
single_list = []
for element in t1:
    single_list.extend(element)
# print(f"\nsingle_list of t1: {single_list}")

rho_bytes = int(ρ, 2).to_bytes((len(ρ) + 7) // 8, byteorder='big')
t1_bytes = b''.join(int(i).to_bytes((int(i).bit_length() + 7) // 8, byteorder='big') for i in single_list)

concatenated_bytes = rho_bytes + t1_bytes
# print(concatenated_bytes)

shake.new(concatenated_bytes)
tr_shake = shake.read(32)  # 256 bits = 32 bytes

tr = ''.join(format(byte, '08b') for byte in tr_shake)
# print(f"\ntr : {tr}")


#---------------------------------------------------- STEP 8 ----------------------------------------------------#
pk = (ρ, t1)
# print(f"\nPublic Key: {pk}")

sk = (ρ, K, tr, s1 , s2 , t0)
# print(f"\nSecret Key: {sk}")