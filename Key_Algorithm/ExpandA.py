# import sys
# import numpy as np

# sys.path.append('/home/hafsa/Dilithium/pycryptodome/lib')

# from Crypto.Cipher import AES


# # STEP 3
# rows, cols = 8, 7
# coefficients_per_polynomial = 256
        
# rho = b'\x99i\xb0$\xe9\xfe\x95U\xb7Pv:\xb4\xcb\x92\x0ct61\x82\xe5;.`/x\t\x90h\xaeN;'

# def expandA(A, rho):
#     for i in range(rows):
#         for j in range(cols):
#             nonce_int = 256 * i + j
#             nonce_bytes = nonce_int.to_bytes(12, byteorder='little')  
            
#             aes = AES.new(rho, AES.MODE_CTR, nonce=nonce_bytes)
#             stream = aes.encrypt(b'\x00' * 768) 
#             # print(f"nonce_int: {nonce_int}, nonce_bytes: {nonce_bytes}, stream: {stream}")

#             for k in range(coefficients_per_polynomial): # 0 to 255
#                 start_ind = k * 3
#                 block = stream[start_ind:start_ind + 3]  #246 blocks
  
#                 block = bytes([block[0], block[1], block[2] & 0x7F])  #(01111111 in binary) that has its highest bit set to 0

#                 combined_int = int.from_bytes(block, byteorder='little')

#                 if combined_int < 8380415:  # q-1 = 8380415
#                     A[i, j, k] = combined_int


# A = np.zeros((rows, cols, coefficients_per_polynomial), dtype=int)
# expandA(A, rho)
# for i in range(rows):
#     for j in range(cols):
#         print(f"\nA[{i}][{j}] = {A[i][j]}")
















import numpy as np
from Crypto.Cipher import AES

# Parameters
rows, cols = 8, 7
coefficients_per_polynomial = 256
q = 8380417
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

# Inverse NTT function
def intt(a, n, q, root):
    inv_n = pow(n, q - 2, q)  # Modular multiplicative inverse of n under q
    a = ntt(a, n, q, pow(root, q-2, q))  # Apply NTT with inverse root of unity
    a = [x * inv_n % q for x in a]  # Scale by n^(-1)
    return a

# Function to expand matrix A
def expandA(A, rho):
    for i in range(rows):
        for j in range(cols):
            nonce_int = 256 * i + j
            nonce_bytes = nonce_int.to_bytes(12, byteorder='little')  
            
            aes = AES.new(rho, AES.MODE_CTR, nonce=nonce_bytes)
            stream = aes.encrypt(b'\x00' * 768) 

            for k in range(coefficients_per_polynomial): # 0 to 255
                start_ind = k * 3
                block = stream[start_ind:start_ind + 3]  #246 blocks
  
                block = bytes([block[0], block[1], block[2] & 0x7F])  #(01111111 in binary) that has its highest bit set to 0

                combined_int = int.from_bytes(block, byteorder='little')

                if combined_int < 8380415:  # q-1 = 8380415
                    A[i, j, k] = combined_int

# Function to apply NTT to the entire matrix
def apply_ntt_to_matrix(A, n, q, root):
    rows, cols = A.shape[:2]
    A_ntt = np.zeros((rows, cols, n), dtype=int)
    
    for i in range(rows):
        for j in range(cols):
            A_ntt[i, j] = ntt(list(A[i, j]), n, q, root)
    
    return A_ntt

# Function to apply inverse NTT to the entire matrix
def apply_intt_to_matrix(A_ntt, n, q, root):
    rows, cols = A_ntt.shape[:2]
    A_original = np.zeros((rows, cols, n), dtype=int)
    
    for i in range(rows):
        for j in range(cols):
            A_original[i, j] = intt(list(A_ntt[i, j]), n, q, root)
    
    return A_original

# Initialize the matrix A
A = np.zeros((rows, cols, coefficients_per_polynomial), dtype=int)
rho = b'\x00' * 16  # Example rho, should be a 16-byte key

# Expand matrix A
expandA(A, rho)

# Print the original matrix A
for i in range(rows):
    for j in range(cols):
        print(f"\nA[{i}][{j}] = {A[i][j]}")

# Apply NTT to the entire matrix
A_ntt = apply_ntt_to_matrix(A, coefficients_per_polynomial, q, root)

# Print the NTT of matrix A
print("\nNTT of matrix A:")
for i in range(rows):
    for j in range(cols):
        print(f"\nA_ntt[{i}][{j}] = {A_ntt[i][j]}")

# Apply inverse NTT to get back the original matrix
A_original = apply_intt_to_matrix(A_ntt, coefficients_per_polynomial, q, root)

# Print the reconstructed original matrix A
print("\nReconstructed original matrix A:")
for i in range(rows):
    for j in range(cols):
        print(f"\nA_original[{i}][{j}] = {A_original[i][j]}")