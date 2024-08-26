import math
def bits_to_bytes(y):                                                        #input = list of binary seperated by ,: [1, 0, 1, 1, 0]
    c = len(y)
    z = [0] * math.ceil(c / 8)  # Initialize z with 0s, length is ⌈c/8⌉

    for i in range(c):
        z[i // 8] += y[i] * (2 ** (i % 8))

    return bytes(z)                                                         #output = bytes

# # Example usage
# y = [1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0]  # Example bit string
# result = bits_to_bytes(y)
# print(result)  # Output should match b'\xb3j'





def IntegerToBits(x, α):                                                      #input = integer
    # Initialize an empty list to store the bits
    y = []

    # Loop from 0 to α-1
    for i in range(α):
        # Compute x mod 2 and store the result in y[i]
        y.append(x % 2)

        # Update x to x // 2
        x = x // 2

    return y                                                                  #output = list of binary seperated by ,: [1, 0, 1, 1, 0]

# # Example usage:
# x = 13  # Example integer
# α = 5   # Example value for α

# result = IntegerToBits(x, α)
# print(f"Base-2 representation of {x} mod 2^{α} in little-endian order is: {result}")





q = 8380417
def CoefFromThreeBytes(b0, b1, b2):                                       #input = integer or bytes
    # Step 1: If b2 > 127, subtract 128 from b2
    if b2 > 127:
        b2 -= 128
    
    # Step 2: Compute z = 2^16 * b2 + 2^8 * b1 + b0
    z = (2**16) * b2 + (2**8) * b1 + b0
    
    # Step 3: Return z if z < q, otherwise return None (representing ⊥)
    if z < q:
        return z
    else:
        return None                                                         #output =  coefficient or integer in range (0 to q-1)

# # Example usage:
# b0 = 15  # Example byte
# b1 = 25  # Example byte
# b2 = 130 # Example byte

# result = CoefFromThreeBytes(b0, b1, b2)
# if result is not None:
#     print(f"The coefficient modulo q is: {result}")
# else:
#     print("The result is ⊥")




rows_k = 8
cols_l = 7
coefficients_per_polynomial = 256
import sys
sys.path.append('/home/hafsa/Athestia/pycryptodome/lib/Crypto/Hash')
from SHAKE128 import SHAKE128_XOF

def RejNTTPoly(rho):                                                      #input = rho or integertobits concatenation
    a = [0] * 256
    j = 0
    c = 0

    # Initialize SHAKE128 instance with seed rho
    # print(rho)
    shake = SHAKE128_XOF()
    shake.update(bits_to_bytes(rho))
    # s = bits_to_bytes(rho)
    # print(s)
    # shake.update(s)
    
    # Read a large chunk of output at once to simulate the byte stream.
    output = shake.read(3*256*2)  # Reading enough bytes for multiple iterations
    # print(output)
    # print(f"Total length of output: {len(output)} bytes")
    
    while j < 256:
        coef = CoefFromThreeBytes(output[c], output[c + 1], output[c + 2])
        c += 3
        # print(f"coef = {coef}")
        if coef is not None:
            a[j] = coef
            j += 1

        # Only increment `c` if j is not 255
        # if j < 255:
        #     c += 3

                # Print the values during the last iteration
        # if j == 255:
        #     print(f"\nLast Iteration:")
        #     print(f"j = {j}, c = {c}")
        #     print(f"b0 = {b0}, b1 = {b1}, b2 = {b2}")
        #     print(f"coef = {coef}")


    return a         
                                                                #output =  list of coefficient                                       

# Example usage:
# rho = [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0]
# result = RejNTTPoly(rho)
# print("Generated polynomial coefficients:")
# print(result)





import numpy as np
def ExpandA(rho, k, l):
    # A_hat = np.zeros((k, l, 256), dtype=np.int64)  # Initialize k x l x 256 matrix
    
    for r in range(k):
        for s in range(l):
            # Concatenate rho, IntegerToBits(s, 8), and IntegerToBits(r, 8)
            rho_concat = rho + IntegerToBits(s, 8) + IntegerToBits(r, 8)
            # print(rho_concat)
            A[r][s] = RejNTTPoly(rho_concat)
    
    return A

# Example usage
rho = [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1]
k = 8
l = 7 

A = np.zeros((k, l, 256), dtype=np.int64)
A = ExpandA(rho, k, l)
# for i in range(k):
#     for j in range(l):
#         print(f"\nA[{i}][{j}] = {A_hat[i][j]}")

# for row in A_hat:
#     print(row)





def CoefFromHalfByte(b, eta):                                               #input = integer or bytes
    if eta == 2 and b < 15:
        return 2 - (b % 5)
    # elif eta == 4 and b < 9:
    #     return 4 - b
    else:
        return None  # Representing ⊥                                       #output =  coefficient or integer in range {−η, −η + 1, . . . , η}

# # Example usage:
# b = 6  # Example value for b
# eta = 2  # Example value for η

# result = CoefFromHalfByte(b, eta)
# print(f"Generated coefficient: {result}")





def RejBoundedPoly(rho_p, eta):
    j = 0
    c = 0
    a = [0] * 256
    # rejected = [] 

    # Initialize SHAKE128 instance with seed rho
    shake = SHAKE128_XOF()
    shake.update(bits_to_bytes(rho_p))
    
    # Read a large chunk of output at once to simulate the byte stream.
    output = shake.read(256)  # Reading enough bytes for multiple iterations
    
    while j < 256:
        z = output[c]
        
        # Step 5: Calculate z0 and z1 using CoefFromHalfByte
        z0 = CoefFromHalfByte(z % 16, eta)  # z mod 16
        z1 = CoefFromHalfByte(z // 16, eta)  # ⌊z/16⌋
        
        # Step 7: If z0 is not ⊥, assign aj and increment j
        if z0 is not None:
            a[j] = z0
            j += 1
        # else:
            # rejected.append(f"z0 from byte {z} (lower half)")
        
        # Step 11: If z1 is not ⊥ and j < 256, assign aj and increment j
        if z1 is not None and j < 256:
            a[j] = z1
            j += 1
        # else:
            # rejected.append(f"z1 from byte {z} (upper half)")
        
        # Step 15: Increment c
        c += 1
    
    return a
    # return a, rejected

# rho = b'\x00' * 66  # Example seed ρ, should be 528 bits (66 bytes)
# eta = 2  # Example value for η (can be 2 or 4)
# # result, rejected_bytes = RejBoundedPoly(rho, eta)
# result = RejBoundedPoly(rho, eta)
# print("Generated polynomial coefficients:")
# print(result)
# # print("\nRejected bytes:")
# # print(rejected_bytes)





# s1 = []
# for _ in range(l):
#     vectors1 = [0] * 256
#     s1.append(vectors1)

# s2 = []
# for _ in range(k):
#     vectors2 = [0] * 256
#     s2.append(vectors2)

def ExpandS(rho_p, l, k, eta):
    s1 = []
    # s1 = np.zeros((l, 256), dtype=np.int64) 
    s2 = []

    # Loop to generate s1 vector
    for r in range(l):
        # Concatenate rho with IntegerToBits(r, 16)
        # rho_concat = rho_p + (IntegerToBits(r, 16))
        # print(rho_concat)
        # poly = RejBoundedPoly(rho_concat, eta)
        s1.append(RejBoundedPoly(rho_p + (IntegerToBits(r, 16)), eta))
        # s1.append(poly)
    
    # Loop to generate s2 vector
    for r in range(k):
        # Concatenate rho with IntegerToBits(r + ℓ, 16)
        rho_concat = rho_p + (IntegerToBits(r + l, 16))
        s2.append(RejBoundedPoly(rho_concat, eta))
    
    return (s1, s2)

# Example usage:
rho_p = [0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1]
l = 7  # Example value for ℓ
k = 8  # Example value for k
eta = 2  # Example value for η

s1, s2 = ExpandS(rho_p, l, k, eta)

# print("Vector s1:")
# for i, poly in enumerate(s1):
#     print(f"s1[{i}]:", poly)

# # Display the generated vectors
# print("Vector s1:")
# for poly in s1:
#     print(poly)

# print("\nVector s2:")
# for poly in s2:
#     print(poly)

# for i in range(l):
#     print(f"s1[{i}] = {s1[i]}")





def postprocess_modular(values):
    return [x if x < q//2 else x - q for x in values]

def bit_reversal(i, k):
        bin_i = bin(i & (2 ** k - 1))[2:].zfill(k)
        return int(bin_i[::-1], 2)

zeta = [pow(1753, bit_reversal(i, 8), q) for i in range(256)] 
# print(zeta)

q = 8380417
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

# Example usage
# Define the polynomial w as a list of 256 integers (example values)
# w1 = [7880476, 451744, 2612419, 5074264, 8057345, 5862479, 1159470, 6881621, 7803227,5605011, 1092305, 2263375, 6261792, 5577792, 2412368, 5402158, 6079575, 6844413,3702803, 998561, 1690382, 7677673, 6123168, 7766007, 5743168, 6713142, 455819,3067609, 6351809, 4210300, 7162613, 1136664, 7633771, 1138303, 3946536, 8325140,6501646, 140624, 1703426, 4756977, 3741005, 5937215, 6743490, 4503092, 3471245,4330469, 360533, 20109, 2815544, 7575078, 8236038, 1081400, 1015334, 35292,3674209, 4255893, 8342571, 5195190, 1603485, 5624023, 5905260, 284864, 8323159,4548416, 8199809, 3672768, 1133365, 7439825, 2493819, 2862221, 2609935, 3387109,7222932, 2248885, 4727378, 5254835, 242144, 6625078, 6206002, 3877024, 5492396,5710902, 8081480, 1812284, 6965709, 7230310, 8075754, 4624349, 7532030, 4682976,886565, 6908590, 822138, 5185269, 2889917, 7379757, 4349963, 2987836, 6548165,6540583, 250848, 984180, 5155680, 3793668, 8132144, 473768, 3394093, 704340,2556217, 7874274, 7703744, 4758769, 59935, 6254227, 8142451, 7676839, 3657875,5395486, 4193660, 4823889, 5246263, 2037395, 628828, 3315207, 7772682, 8080349,6564651, 3963647, 1913272, 844387, 5495015, 3315844, 7244499, 3131187, 3807466,7518840, 7830114, 6660064, 3840286, 614141, 1031109, 1780498, 3647036, 6185400,6814620, 7588938, 196334, 644539, 2742945, 927420, 1135203, 5214368, 3202752,2062391, 1160126, 1889602, 67381, 126177, 4630344, 4717578, 6203326, 6828681,1749278, 5777169, 700203, 4481208, 1998389, 1159203, 2462815, 1371365, 1935629,2096957, 4338818, 2977425, 1597098, 5275346, 1863803, 4370603, 2365155, 3232473,2522191, 2599081, 3623794, 4818420, 988569, 5584896, 2587033, 2404352, 3604662,4094960, 6155224, 6716109, 5779273, 6185017, 3339991, 3672080, 4719368, 5064736,7749708, 4913372, 2585269, 1646940, 6465207, 8170505, 7402741, 5813164, 6580893,664077, 168097, 3870236, 8372834, 635740, 4470203, 6565736, 238535, 4668018,2352307, 1475803, 6886060, 8060550, 6821470, 8361338, 6718716, 5995672, 5386539,6392092, 6374388, 5405427, 65299, 1441592, 155920, 3488139, 2245751, 5394230,3015088, 2635135, 4191484, 5383295, 2722216, 5684476, 5080686, 5639889, 399119,2843516, 1496287, 5736860, 4368129, 7883109, 7033043, 335948, 6086876, 6674233,4079818, 2719822, 2386356, 2041457]
w1 = [0, 1, -2, 2, 0, 2, 2, 1, -2, 1, 0, 2, -1, 2, -2, -1, -1, 1, -2, 2, -1, 0, 0, -1, 2, 1, 1, 2, -1, 0, 1, -1, -2, -1, -2, 1, 0, -1, 0, -1, -1, -2, 1, -2, 2, 1, 2, 0, 1, 2, -2, 2, 0, -2, 0, 1, 1, 1, -1, 2, 0, -2, 1, -2, -2, 2, -2, 2, 1, -1, -2, -1, -1, -1, 1, 2, -1, -2, 2, 2, 0, -2, 2, 2, 2, -2, 0, -2, -1, 2, -2, -1, -2, 0, 1, 0, -1, 2, 2, 1, 1, 2, -2, 2, -2, 2, -1, 1, 2, 1, 2, 2, -1, 1, -1, 2, 2, 2, 1, 0, 1, 1, 2, 2, -2, 0, -2, -1, 2, 1, -2, -2, 0, -1, -2, 1, 0, 0, 1, 1, 0, 0, 1, 1, -2, 0, 2, 1, 1, 2, -1, 0, -1, 1, -1, 0, 0, 0, 1, 2, 0, 0, 2, -2, 2, 2, 0, -1, -1, -2, -1, 1, 2, 0, -2, -2, -1, 0, 1, 1, 1, 1, 0, 2, 2, 1, -2, -2, 1, -2, -1, -2, -1, -2, -1, 1, -2, -1, 0, 2, -2, -2, 0, 1, 2, 2, 1, 0, 0, 0, -1, 2, -2, 2, 2, -1, 0, 0, 1, 2, -1, -2, 0, 1, 2, -2, 0, 0, 0, -2, 2, 1, -2, 1, 2, -1, -1, 0, -2, 1, 0, 1, -2, 1, -2, 1, 0, -1, 2, 2, 1, 1, -2, 1, 1, -1]

# zeta = [pow(1753, i, q) for i in range(256)]  # Precompute ζ^brv(k) mod q

# self.ntt_zetas = [pow(self.root_of_unity, self._bit_reversal(i, 8), self.q) for i in range(self.n)]

# Compute the NTT
w_hat = ntt(w1)
# print(w_hat)





def ntt_inverse(w_hat):
    # Initialize w with the input w_hat
    # w = [0] * 256
    # for j in range(256):
    #     w[j] = w_hat[j]
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
    
    # Multiply by the inverse factor f
    # f = 8347681  # f = 256^{-1} mod q
    f = pow(256, -1, q)  # Modular inverse of 256 mod q
    for j in range(256):
        w[j] = (f * w[j]) % q
    
    return w

# Example usage
# Define the transformed polynomial w_hat as a list of 256 integers (example values)
# w_hat = [1435785, 7829045, 5131857, 1030506, 6069581, 6626488, 2478644, 285206, 4481108, 3039097, 4838109, 7222012, 3298758, 4811648, 3854692, 4387884, 6505359, 6843674, 2023779, 5964413, 7120086, 3539260, 899586, 6483471, 6462571, 6811886, 1761298, 3330431, 544565, 5007224, 5987151, 1376047, 3015378, 8335059, 1499455, 5023556, 7084435, 6579026, 3792224, 2170336, 6934017, 892172, 1009290, 281694, 5851301, 1365540, 903822, 3643409, 707266, 7140445, 7835167, 4648865, 676125, 291478, 7068888, 716361, 7553311, 3988881, 835693, 6162041, 7398349, 4928172, 2210217, 4132063, 4513089, 768199, 2154620, 3780640, 6612924, 7668586, 5668582, 653742, 4698217, 5632106, 197320, 6405219, 6744634, 6683512, 8223371, 3835917, 3640553, 2585552, 6944919, 6152932, 5160845, 7958291, 7810482, 2348572, 4785210, 7367621, 3105202, 4526306, 1342990, 4146002, 3455534, 2675882, 1632811, 1985259, 5609152, 7192276, 3817954, 1580856, 2040707, 4809521, 3769986, 5648075, 7382101, 783874, 6858707, 4870909, 7230723, 352070, 3131878, 1327518, 8164502, 7605601, 1697675, 4639914, 1058069, 3368030, 5506142, 5333462, 6123642, 1835556, 160169, 2172658, 2332406, 4594917, 3042598, 4901979, 2983064, 923007, 6912130, 4639995, 5986855, 4925990, 2808086, 1713627, 7928433, 3394668, 7336869, 6889198, 141563, 2458214, 3832239, 4946552, 6816491, 7055445, 5725628, 1640278, 4906379, 6589972, 6391107, 3628697, 1016416, 3430140, 2777582, 6730672, 8202744, 2661976, 7211226, 8065909, 6011584, 7331554, 6012293, 4816090, 3882452, 6523107, 4315093, 1996478, 3877205, 76290, 5171684, 6668736, 7389273, 786500, 6408467, 1972257, 143458, 2106279, 4991506, 181651, 4605488, 5615104, 2621957, 7902493, 1658900, 3769648, 1595331, 595047, 95606, 4552863, 5529906, 8368337, 4282582, 796171, 4058995, 5446764, 7360190, 7373932, 4041758, 6804516, 4460835, 1549086, 3954782, 3500414, 3092815, 6113104, 1578769, 2547433, 8369319, 3535040, 2303621, 2603138, 4621285, 6184961, 4276341, 7012036, 2376299, 72409, 298476, 5673870, 5172223, 1188443, 7676832, 7629817, 4851163, 7834211, 2661901, 652097, 1977776, 4229219, 5943687, 1972479, 4939336, 5358903, 2968521, 8071102, 119492, 7386393, 1050085, 4075387, 7301643, 5842203, 1229268, 2532924, 748980, 7494285, 2531694, 603440, 4272269, 2537166, 1036378, 4910863, 5420250, 2697050]
# w_hat = [2910649, 1423034, 7821404, 2138132, 6951900, 2319747, 2866763, 2125647, 2319944, 2411793, 6486114, 2516134, 7129052, 5843595, 7049491, 2797169, 4994691, 238702, 57504, 2514885, 4026254, 2921510, 4997645, 4749067, 4163982, 4636842, 6182751, 1274807, 5641008, 2147921, 2910391, 8058893, 794144, 2511694, 2078945, 6467478, 649616, 1648317, 7946172, 2899108, 1921020, 2141231, 5928124, 7322756, 6066941, 3821046, 6626718, 1643823, 4652837, 812787, 8121388, 7866689, 5039377, 1443660, 5323683, 788542, 5463849, 5150119, 1133567, 1017996, 5373060, 6162927, 3025249, 2848182, 201467, 317806, 2899242, 5874950, 102480, 3531554, 4496480, 8042677, 7065558, 6600442, 2046330, 5891765, 2286204, 8351578, 5419228, 8213157, 1211279, 4170350, 4686847, 1397115, 2761829, 1216952, 880250, 3417046, 6656677, 1125440, 2232029, 2892184, 3731166, 6881387, 1430715, 7069080, 2522339, 482615, 7363565, 7204455, 6350140, 6020620, 6865162, 5549509, 7612549, 490720, 1097501, 8079153, 7328846, 5495031, 4669452, 5487733, 7717333, 1586958, 4598820, 1279002, 5927690, 2065366, 327197, 8091673, 4948110, 1569640, 5370878, 8158571, 3049757, 7820863, 6583693, 4136661, 1809040, 959005, 4029553, 8173424, 5459136, 6469294, 5732401, 4100461, 523168, 6183844, 1317193, 1892320, 2337168, 7867874, 6711388, 1788059, 4398261, 4957884, 1031061, 6261797, 4905351, 1654245, 8036302, 1704021, 4585822, 5307479, 4156726, 7268680, 23941, 5576623, 5432880, 6759117, 6082248, 569395, 5423384, 6836230, 2780070, 4552978, 1136019, 2749729, 2167273, 2550542, 4245160, 863053, 2226391, 4225522, 692735, 1216544, 3408899, 3165722, 6963094, 7006668, 7425828, 5973817, 2440135, 4053090, 4278710, 6179827, 5780827, 8203737, 5218965, 3009147, 3391688, 631332, 3610676, 4741019, 5075235, 1068840, 2402037, 3604469, 6808919, 2854223, 3053173, 4881202, 702773, 5060710, 2645229, 8329514, 5355710, 6368354, 225083, 4675982, 203890, 3823724, 3503402, 3655128, 351819, 406160, 344076, 6596508, 6392286, 3612790, 4680214, 7133695, 3159242, 3118461, 5901717, 238443, 245005, 5181371, 5121789, 6527002, 7775412, 6862118, 5135704, 1806681, 966156, 6712596, 49522, 6435710, 4212535, 2637958, 5987230, 7925726, 165040, 2243734, 4470729, 4317230, 1067241, 2430795, 4213655, 4767260, 2028531, 7479495, 5562456, 3796839, 6029872, 7399780]
w_hat = [5490568, 3613684, 4600186, 2478491, 6246056, 3652416, 6012214, 8219157, 6727900, 2382610, 6832291, 7450424, 907815, 7682907, 3459268, 3609848, 6195500, 405136, 7621195, 248334, 3220617, 2175833, 2352260, 7089623, 4020074, 6213427, 2527846, 7429138, 6999544, 1186882, 3101343, 7435361, 5981894, 7541451, 4715541, 2901097, 5402912, 7725834, 1230626, 2072619, 7991783, 3844773, 1383397, 4583243, 8044557, 7765607, 1385806, 3962639, 5760469, 5996065, 1996518, 628913, 5574056, 4954001, 7353971, 4511181, 2765304, 8333155, 7614721, 2035006, 8379476, 2741076, 7038906, 3550192, 5738363, 588418, 3166249, 6248274, 2593682, 2206637, 4129647, 3985612, 2897488, 3595058, 2452509, 6052571, 8196615, 7073012, 4554819, 4389763, 7464083, 2423240, 6824432, 6865694, 6024359, 2004695, 7425569, 4671534, 1643530, 1505444, 5194258, 5701664, 4965815, 713503, 2547364, 5396658, 4205693, 7237992, 2631853, 6117534, 5698634, 3028526, 6575006, 1096837, 4767151, 3152875, 2470663, 5564669, 3994248, 6042451, 1909829, 8287321, 7992700, 12727, 5893749, 690436, 3100933, 3365152, 2644015, 328408, 1158733, 5880891, 7327186, 513870, 8232623, 579857, 6533404, 7593876, 7772529, 1564319, 5088069, 2575447, 1781113, 7797503, 4661947, 7423384, 8012964, 3080105, 3824135, 5907938, 5836802, 1626015, 8116876, 208538, 8166760, 353456, 516009, 6914942, 5010197, 4461670, 7266118, 203269, 5611503, 2711529, 5250740, 5594044, 1714980, 8104313, 7291838, 5992432, 2370002, 5065357, 3563653, 1927043, 7736515, 4191036, 1358291, 3134211, 7198172, 1627271, 4986459, 6916175, 4495144, 4876714, 2987944, 7052275, 1161047, 1330671, 8357759, 1221870, 8263453, 2640431, 2847381, 8011473, 4013074, 1266294, 8345863, 1471067, 7800365, 3585296, 3703947, 3931817, 3074965, 7487410, 4785794, 4681176, 3176780, 4805149, 2874405, 5749262, 5427515, 7272295, 1200911, 1648076, 6870671, 1445933, 4271706, 7589312, 5713463, 4308755, 1316360, 7253909, 5124805, 6851173, 1074042, 849589, 2806098, 4432704, 6792189, 7019501, 4310014, 1260882, 1859626, 4072089, 1535765, 1179386, 8135319, 3731109, 4284830, 7351607, 495555, 574510, 1978127, 1798821, 1159937, 6006938, 3508211, 4595611, 6548214, 6383581, 787626, 1210233, 1926406, 7698577, 482732, 5436624, 3725231, 7930510, 4248001, 6466583, 231576, 7871019, 8319489, 2298367, 6460142, 4484407]

# Compute the inverse NTT
w = ntt_inverse(w_hat)
# print()
# print(w)

# # Check if the original and recovered polynomials match
# print("Match:", w1 == w)





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





def compute_t(A_ntt, s1_ntt, s2):
    t_ntt = []
    for _ in range(rows_k):
        vector_ntt_t = [0] * coefficients_per_polynomial
        t_ntt.append(vector_ntt_t)

    t = []
    for _ in range(rows_k):
        vector_invntt_t = [0] * coefficients_per_polynomial
        t.append(vector_invntt_t)
    # t = []
    # t_ntt = []

    for i in range(rows_k):
        for j in range(cols_l):
            # t[i] += A[i][j] * s1[j]
            t_ntt[i] += A_ntt[i][j] * s1_ntt[j]
    # print("\nt before adding s2:")
    # for i in t:
    #     print(i)
    # print("\nt_ntt before adding s2:")
    # for i in t_ntt:
    #     print(i)

    for i in range(rows_k):
        # t[i] = (postprocess_modular(ntt_inverse(t_ntt[i])))
        t[i] = ntt_inverse(t_ntt[i])
    # print("\nt in invNTT before adding s2:")
    # for vect in t:
    #     print(vect)

    for i in range(8):
        t[i] += s2[i]

    return t

t = compute_t(A_ntt, s1_ntt, s2)

# print("Vector t:")
# for i in range(len(t)):
#     print(f"\nt[{i}] = {t[i]}")




d = 13
def power2round(t):
    t_mod_q = t % q

    t0 = t_mod_q % (2**d)

    t1 = (t_mod_q - t_mod_2d) // (2**d)

    return t1, t0

t1, t0 = power2round(t)
# print("t1:", t1)
# print("t0:", t0)


for i in range(len(t)):
    for j in range(256):
        t1_coef, t0_coef = power2round(t[i][j])
        t1[i][j] = t1_coef
        t0[i][j] = t0_coef

# # print("Vector t1:")
# # for i, poly in enumerate(t1):
# #     print(f"\nt1[{i}]: {poly}")

# # print("Vector t0:")
# # for i, poly in enumerate(t0):
# #     print(f"\nt0[{i}]: {poly}") 





def simple_bit_pack(w, b):
    z = []

    # Loop over each coefficient in the polynomial w
    for i in range(256):  # Assuming w has 256 coefficients
        # Concatenate the bit representation of each coefficient
        z = z + IntegerToBits(w[i], b)

    # Convert the bit string to bytes
    return bits_to_bytes(z)

# # Example usage:
# # Example polynomial with coefficients in [0, b], where b = 7 (which corresponds to 3 bits)
# t1 = [720, 864, 984, 184, 460, 454, 853, 292, 135, 765, 256, 906, 923, 430, 241, 257, 308, 513, 135, 337, 590, 614, 699, 762, 949, 101, 671, 977, 295, 673, 76, 137, 396, 402, 890, 705, 753, 57, 288, 348, 159, 974, 98, 510, 732, 324, 941, 657, 692, 795, 946, 884, 751, 309, 241, 188, 936, 615, 819, 828, 501, 805, 211, 119, 834, 230, 610, 951, 785, 862, 751, 270, 315, 690, 990, 92, 341, 902, 225, 460, 314, 827, 298, 861, 450, 758, 557, 83, 620, 821, 899, 413, 349, 198, 424, 732, 229, 1013, 714, 594, 406, 240, 777, 424, 90, 219, 28, 405, 106, 287, 73, 663, 162, 120, 352, 608, 657, 411, 822, 60, 510, 971, 397, 161, 414, 16, 672, 584, 291, 238, 165, 885, 1019, 468, 588, 874, 543, 220, 350, 209, 72, 1015, 178, 331, 88, 369, 762, 931, 551, 84, 295, 643, 496, 481, 299, 151, 573, 159, 415, 282, 549, 68, 373, 639, 734, 386, 347, 870, 550, 312, 549, 569, 546, 876, 103, 760, 193, 647, 355, 533, 384, 660, 282, 489, 293, 388, 635, 440, 1017, 485, 702, 33, 738, 315, 1022, 478, 519, 720, 981, 842, 767, 535, 68, 182, 399, 188, 413, 573, 991, 14, 321, 693, 204, 420, 209, 988, 319, 360, 169, 922, 778, 755, 819, 370, 222, 453, 750, 614, 27, 704, 210, 994, 84, 323, 766, 373, 823, 47, 728, 114, 823, 895, 503, 593, 340, 716, 669, 809, 224, 638, 195, 273, 193, 619, 488, 422]
# b = 10 # The bit length for each coefficient
# result = simple_bit_pack(t1, b)
# print(result)





def pk_encode(rho, t1):
    # Step 1: Encode ρ as a byte string
    pk = bits_to_bytes(rho)
    # print(pk)
    
    # Calculate the bit length for each coefficient
    bitlen = math.ceil(math.log2(q - 1)) - d
    # value = 2 ** bitlen - 1
    # print(bitlen)
    
    # Step 2-4: Encode each element of t1 and concatenate to pk
    for i in range(rows_k):
        pk = pk + simple_bit_pack(t1[i], bitlen)

    return pk

result = pk_encode(rho, t1)
# print(f"\npk : {result}") 





def bytes_to_bits(z):
    y = []
    d = len(z)
    
    # Step 1-6: Convert each byte in z to bits
    for i in range(d):
        for j in range(rows_k):
            y.append(z[i] % 2)  # Get the least significant bit
            z[i] //= 2  # Shift the byte right by 1 bit
    
    # Step 7: Return the bit string y
    return y

# Example usage:
# pk = b'\x01\x02\x03'  # Example byte string
# tr = bytes_to_bits(list(pk))
# print(tr)





# from SHAKE256 import SHAKE256_XOF
def compute_tr(pk):
    # Step 1: Convert pk (byte string) to a bit string
    bit_string = bytes_to_bits(list(pk))

    # Step 2: Hash the bit string using SHAKE256 to get 512 bits (64 bytes)
    shake = SHAKE256_XOF()
    shake.update(bits_to_bytes(bit_string))  # Encoding the bit string to bytes
    tr = shake.read(64)  # 512 bits = 64 bytes

    return tr

# Example usage
# pk = b'@\x8d]...'  # Your pk byte string here
tr = compute_tr(pk)
# print(f"\ntr : {tr}") 





def BitPack(w, a, b):
    z = []  # Initialize an empty list to store bits

    bitlen = math.ceil(math.log2(a + b))  # Compute bit length for (a + b)

    for i in range(256):
        z += IntegerToBits(b - w[i], bitlen)

    return bits_to_bytes(z)  # Convert the bit list to bytes and return

# Example usage
w = [0, 1, 2, 3, 4]  # Example polynomial coefficients
a = 2
b = 5
encoded_bytes = BitPack(w, a, b)
print(f"Encoded bytes: {encoded_bytes}")





# def skEncode(ρ, K, tr, s1, s2, t0, η, d):
#     sk = bits_to_bytes(ρ) + bits_to_bytes(K) + bits_to_bytes(tr)  # Concatenate ρ, K, and tr
    
#     # Encode s1 with BitPack
#     for i in range(len(s1)):
#         sk += BitPack(s1[i], η, η)
    
#     # Encode s2 with BitPack
#     for i in range(len(s2)):
#         sk += BitPack(s2[i], η, η)
    
#     # Encode t0 with BitPack
#     for i in range(len(t0)):
#         sk += BitPack(t0[i], 2**(d-1)-1, 2**(d-1)-1)

#     return sk

# # Example usage:
# ρ = [0] * 32  # Example 256-bit value (32 bytes)
# K = [1] * 32  # Example 256-bit value (32 bytes)
# tr = [2] * 64  # Example 512-bit value (64 bytes)

# # Example polynomials s1, s2, and t0 with coefficients in the specified ranges
# s1 = [[1, -1, 0] * 85 + [1]] * 3  # ℓ = 3, each s1[i] has 256 coefficients
# s2 = [[-1, 1, 0] * 85 + [-1]] * 2  # k = 2, each s2[i] has 256 coefficients
# t0 = [[1, 0, -1] * 85 + [1]] * 2  # k = 2, each t0[i] has 256 coefficients

# η = 1  # Example η value
# d = 10  # Example d value

# # Call the skEncode function
# sk = skEncode(ρ, K, tr, s1, s2, t0, η, d)
# print(sk)  # Outputs the encoded private key

