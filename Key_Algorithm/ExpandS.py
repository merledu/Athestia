# import sys
# import numpy as np

# sys.path.append('/home/hafsa/Dilithium/pycryptodome/lib')

# from Crypto.Cipher import AES


# # STEP 4
# rows, cols = 8, 7
# η = 2
# coefficients_per_polynomial = 256

# s1 = []
# for _ in range(cols):
#     vectors1 = [0] * coefficients_per_polynomial
#     s1.append(vectors1)

# s2 = []
# for _ in range(rows):
#     vectors2 = [0] * coefficients_per_polynomial
#     s2.append(vectors2)


# rho0 = b"s\x93\xf6\xf8\x1bo\x98\xe9\x13o\x19\xcc\xf1\xdaK/G\xf3n\x93\xb0\"\xa8\'U\xa8\xfeW\xe6\xabrk\x00-6\x1a\xc4i@\xf7p~\xbck\x9eG\x82&\x9f\x96GGBA\xdf?.I)\xb7EL\xf2\xc7"

# def expandS1(s1, rho0):
#     for i in range(cols):
#         nonce_int = i
#         nonce_bytes = nonce_int.to_bytes(12, byteorder='big')  
        
#         aes = AES.new(rho0[:32], AES.MODE_CTR, nonce=nonce_bytes)
#         stream = aes.encrypt(b'\x00' * 4) 
#         # print(f"nonce_int: {nonce_int}, nonce_bytes: {nonce_bytes}, stream: {stream}")

#         aes_binary = ''
#         for byte in stream:
#             binary = format(byte, '08b')
#             aes_binary += binary
#         # print(f"aes_binary: {aes_binary}")


#         coefficients = []
#         for _ in range(coefficients_per_polynomial // 2):
#             lower_4_bits = aes_binary[-4:]
#             upper_4_bits = aes_binary[:4]

#             r1 = int(lower_4_bits, 2) % 5
#             r2 = int(upper_4_bits, 2) % 5

#             r1_int = η - r1
#             r2_int = η - r2

#             if (r1_int & r2_int) <= (1 << 23):
#                 r1_int = int(format(r1_int, '023b'), 2)  
#                 r2_int = int(format(r2_int, '023b'), 2)  
#             elif (r1_int & r2_int) > (1 << 23):
#                 r1_int = int(format(r1_int, '023b')[:23], 2) 
#                 r2_int = int(format(r2_int, '023b')[:23], 2) 

#             coefficients.append(r1_int)
#             coefficients.append(r2_int)
            
#         s1[i] = coefficients



# expandS1(s1, rho0)

# print("s1:")
# for i in s1:
#     print(i)






import numpy as np
from Crypto.Cipher import AES

# Parameters
cols = 7
coefficients_per_polynomial = 256
q = 8380417
root = 1753
η = 2

# Initialize s1
s1 = []
for _ in range(cols):
    vectors1 = [0] * coefficients_per_polynomial
    s1.append(vectors1)

# Function to expand s1
def expandS1(s1, rho0):
    for i in range(cols):
        nonce_int = i
        nonce_bytes = nonce_int.to_bytes(12, byteorder='big')  
        
        aes = AES.new(rho0, AES.MODE_CTR, nonce=nonce_bytes)
        stream = aes.encrypt(b'\x00' * 4)
        
        aes_binary = ''
        for byte in stream:
            binary = format(byte, '08b')
            aes_binary += binary
        
        coefficients = []
        for j in range(coefficients_per_polynomial // 2):
            lower_4_bits = aes_binary[-4:]
            upper_4_bits = aes_binary[:4]

            r1 = int(lower_4_bits, 2) % 5
            r2 = int(upper_4_bits, 2) % 5

            r1_int = η - r1
            r2_int = η - r2 

            coefficients.append(r1_int)
            coefficients.append(r2_int)

        s1[i] = coefficients

# Function to apply NTT to a vector
def apply_ntt_to_vector(vector, n, q, root):
    return ntt(vector, n, q, root)

# Function to apply NTT to the entire matrix
def apply_ntt_to_matrix(A, n, q, root):
    A_ntt = []
    for vector in A:
        A_ntt.append(apply_ntt_to_vector(vector, n, q, root))
    return A_ntt

# Example key for AES
rho0 = b'\x00' * 32  # Use an actual secure key in practice

# Expand s1 with the given key
expandS1(s1, rho0)

# Apply NTT to each vector in s1
s1_ntt = apply_ntt_to_matrix(s1, coefficients_per_polynomial, q, root)

# Output the NTT transformed s1
print("NTT of s1:")
for vector in s1_ntt:
    print(vector)


# Inverse NTT function
def intt(a, n, q, root):
    root_inv = pow(root, q-2, q)  # Compute the modular inverse of root
    inv_n = pow(n, q-2, q)        # Compute the modular inverse of n under q
    a = ntt(a, n, q, root_inv)    # Apply NTT with inverse root of unity
    a = [(x * inv_n) % q for x in a]  # Scale each element by n^(-1)
    return a

# Function to apply inverse NTT to a vector
def apply_intt_to_vector(vector, n, q, root):
    return intt(vector, n, q, root)


# Apply inverse NTT to the transformed s1_ntt
s1_original = apply_intt_to_matrix(s1_ntt, coefficients_per_polynomial, q, root)

# Output the reconstructed s1 to verify correctness
print("Reconstructed s1 from NTT:")
for vector in s1_original:
    print(vector)
































# def expandS2(s2, rho0):
#     for i in range(rows):
#         nonce_int = i
#         nonce_bytes = nonce_int.to_bytes(12, byteorder='big')  
        
#         aes = AES.new(rho0[:32], AES.MODE_CTR, nonce=nonce_bytes)
#         stream = aes.encrypt(b'\x00' * 4) 
#         # print(f"nonce_int: {nonce_int}, nonce_bytes: {nonce_bytes}, stream: {stream}")

#         aes_binary = ''
#         for byte in stream:
#             binary = format(byte, '08b')
#             aes_binary += binary
#         # print(f"aes_binary: {aes_binary}")


#         coefficients = []
#         for _ in range(coefficients_per_polynomial // 2):
#             lower_4_bits = aes_binary[-4:]
#             upper_4_bits = aes_binary[:4]

#             r1 = int(lower_4_bits, 2) % 5
#             r2 = int(upper_4_bits, 2) % 5

#             r1_int = η - r1
#             r2_int = η - r2

#             if (r1_int & r2_int) <= (1 << 23):
#                 r1_int = int(format(r1_int, '023b'), 2)  
#                 r2_int = int(format(r2_int, '023b'), 2)  
#             elif (r1_int & r2_int) > (1 << 23):
#                 r1_int = int(format(r1_int, '023b')[:23], 2) 
#                 r2_int = int(format(r2_int, '023b')[:23], 2) 

#             coefficients.append(r1_int)
#             coefficients.append(r2_int)
            
#         s2[i] = coefficients


# expandS2(s2, rho0)

# print("\ns2:")
# for i in s2:
#     print(i)