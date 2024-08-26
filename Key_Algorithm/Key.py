import sys
import random
import numpy as np

sys.path.append('/home/hafsa/Athestia/pycryptodome/lib/Crypto/Hash')
sys.path.append('/home/hafsa/Athestia/pycryptodome/lib')
sys.path.append('/home/hafsa/Athestia/Key_Algorithm')

from SHAKE256 import SHAKE256_XOF
from Crypto.Cipher import AES
from Crypto.Cipher import _mode_ctr
from ntt_giacomo import PolynomialDilithiumProcessor

def keygen():
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
    K_bytes = output[96:]         # Last 256 bits

    ρ = ''.join(format(byte, '08b') for byte in rho)
    # print(f"\nρ : {ρ}")
    # print("ρ':", ''.join(format(byte, '08b') for byte in rho0))
    K = ''.join(format(byte, '08b') for byte in K_bytes)
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


    A = np.zeros((rows, cols, coefficients_per_polynomial), dtype=np.int64)
    expandA(A, rho)
    # for i in range(rows):
    #     for j in range(cols):
    #         print(f"\nA[{i}][{j}] = {A[i][j]}")


    #-------------------- NTT & invNTT ---------------------#
    ntt = PolynomialDilithiumProcessor()

    A_ntt = np.zeros((rows, cols, coefficients_per_polynomial), dtype=int)
    for i in range(rows):
        for j in range(cols):
            A_ntt[i, j] = ntt.to_ntt(A[i, j].tolist())

    # for i in range(rows):
    #     for j in range(cols):
    #         print(f"A_NTT[{i}][{j}] = {A_ntt[i][j]}")


    A_invntt = np.zeros((rows, cols, coefficients_per_polynomial), dtype=int)
    for i in range(rows):
        for j in range(cols):
            A_invntt[i, j] = ntt.from_ntt(A_ntt[i, j].tolist())

    # for i in range(rows):
    #     for j in range(cols):
    #         print(f"A_InvNTT[{i}][{j}] = {A_invntt[i][j]}")


    #---------------------------------------------------- STEP 4 ----------------------------------------------------#
    q = 8380417
    η = 2

    s1 = []
    for _ in range(cols):
        vectors1 = [0] * coefficients_per_polynomial
        s1.append(vectors1)

    s2 = []
    for _ in range(rows):
        vectors2 = [0] * coefficients_per_polynomial
        s2.append(vectors2)

    def expand_s(s1, s2, rho0):    
        for i in range(cols + rows):
            nonce = i.to_bytes(2, 'little') + b'\x00' * 10  # 2 bytes for i, padded to 12 bytes

            aes = AES.new(rho0[:32], AES.MODE_CTR, nonce=nonce)
            stream = aes.encrypt(b'\x00' * 128) 
            # print("Stream:", stream)
            # print("Stream:", len(stream))

            aes_binary = ''
            for byte in stream:
                binary = format(byte, '08b')
                aes_binary += binary
            # print(f"aes_binary: {aes_binary}")

            positive_numbers = []

            for byte in stream:
                formatted_byte = format(byte, '08b')
                #print("byte:", formatted_byte)

                low_4_bits = int(formatted_byte) & 0x0F
                high_4_bits = (int(formatted_byte) >> 4) & 0x0F
                # print(low_nibble)
                if low_4_bits <= 15:
                    positive_numbers.append(low_4_bits % 5)
                if high_4_bits <= 15:
                    positive_numbers.append(high_4_bits % 5)
            
            # print("Positive numbers:", positive_numbers)
            # print("Number of coefficients generated:", len(positive_numbers))
            
            if i < cols:
                s1[i] = positive_numbers
            else:
                s2[i - cols] = positive_numbers

        return s1, s2

    expand_s(s1, s2, rho0)

    # print("\ns1:")
    # for i in s1:
    #     print(i)


    # print("\ns2:")
    # for i in s2:
    #     print(i)


    #-------------------- NTT & invNTT ---------------------#
    s1_ntt = [ntt.to_ntt(vec) for vec in s1]
    # print("\ns1 in NTT form:")
    # for vec in s1_ntt:
    #     print(vec)

    s1_invntt = [ntt.from_ntt(vec1) for vec1 in s1_ntt]
    # print("\ns1 in invNTT:")
    # for vec1 in s1_invntt:
    #     print(vec1)


    #---------------------------------------------------- STEP 5 ----------------------------------------------------#
    t_ntt = []
    for _ in range(rows):
        vector_ntt_t = [0] * coefficients_per_polynomial
        t_ntt.append(vector_ntt_t)

    t = []
    for _ in range(rows):
        vector_invntt_t = [0] * coefficients_per_polynomial
        t.append(vector_invntt_t)

    # print("\nt:")
    # for i in t:
    #     print(i)


    def compute_t(A_ntt, s1_ntt, s2):
        for i in range(8):
            for j in range(7):
                t_ntt[i] += A_ntt[i][j] * s1_ntt[j]
        # print("\nt_ntt before adding s2:")
        # for i in t_ntt:
        #     print(i)

        for i in range(8):
            t[i] = ntt.from_ntt(t_ntt[i])
        # print("\nt in invNTT before adding s2:")
        # for vect in t:
        #     print(vect)

        for i in range(8):
            t[i] += s2[i]
    

    compute_t(A_ntt, s1_ntt, s2)
    # print("\nt:")
    # for i in t:
    #     print(i)


    # #---------------------------------------------------- STEP 6 ----------------------------------------------------#
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
            t1_coef, t0_coef = power2round(t[i][j], d)
            t1[i][j] = t1_coef
            t0[i][j] = t0_coef

    # print("\nt1:")
    # for i in t1:
    #     print(i)

    # print("\nt0:")
    # for i in t0:
    #     print(i)


    # #---------------------------------------------------- STEP 7 ----------------------------------------------------#
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


    # #---------------------------------------------------- STEP 8 ----------------------------------------------------#
    pk = (ρ, t1)
    # print(f"\nPublic Key: {pk}")

    sk = (ρ, K, tr, s1 , s2 , t0)
    # print(f"\nSecret Key: {sk}")

    return pk, sk

pk, sk = keygen()
