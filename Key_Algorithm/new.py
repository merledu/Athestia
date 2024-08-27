q = 8380417
rows_k = 8
cols_l = 7
coefficients_per_polynomial = 256
eta = 2
η = 2
d = 13


#---------------------------------------------------- FUNCTIONS ----------------------------------------------------#
def bits_to_bytes(y):                                                       
    c = len(y)
    z = [0] * math.ceil(c / 8)  

    for i in range(c):
        z[i // 8] += y[i] * (2 ** (i % 8))

    return bytes(z)  


def IntegerToBits(x, α):
    y = []

    for i in range(α):
        y.append(x % 2)
        x = x // 2
    return y


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
def CoefFromThreeBytes(b0, b1, b2):
    if b2 > 127:
        b2 -= 128

    z = (2**16) * b2 + (2**8) * b1 + b0

    if z < q:
        return z
    else:
        return None


def RejNTTPoly(rho):                                                    
    a = [0] * 256
    j = 0
    c = 0

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
def CoefFromHalfByte(b):                                      
    if eta == 2 and b < 15:
        return 2 - (b % 5)
    else:
        return None


def RejBoundedPoly(rho_p):
    j = 0
    c = 0
    a = [0] * 256

    shake = SHAKE128_XOF()
    shake.update(bits_to_bytes(rho_p))
    output = shake.read(256)  # Reading enough bytes for multiple iterations
    
    while j < 256:
        z = output[c]

        z0 = CoefFromHalfByte(z % 16) 
        z1 = CoefFromHalfByte(z // 16)
    
        if z0 is not None:
            a[j] = z0
            j += 1

        if z1 is not None and j < 256:
            a[j] = z1
            j += 1

        c += 1
    
    print(f"Sample coefficients for {rho_p}: {a[:10]}")
    return a


#----------------------------------- ExpandS -----------------------------------#
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
# def power2round(t):
#     t_mod_q = t % q

#     t_mod_2d = t_mod_q % (2**d)

#     t1 = (t_mod_q - t_mod_2d) // (2**d)
#     t0 = t_mod_2d

#     return t1, t0


def power2round(t):
    t_mod_q = t % q
    t_mod_2d = t_mod_q % (2**d)
    if t_mod_2d >= 2**(d-1):
        t_mod_2d -= 2**d
    t1 = (t_mod_q - t_mod_2d) // (2**d)
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


# def check_t1(t1, q=8380417, d=13, rows_k=8, coefficients_per_polynomial=256):
#     # Calculate the maximum value for t1 coefficients
#     bitlen = math.ceil(math.log2(q - 1)) - d
#     max_value = (2 ** bitlen) - 1

#     # Check the shape of t1
#     if len(t1) != rows_k or any(len(row) != coefficients_per_polynomial for row in t1):
#         print("Error: t1 matrix does not have the correct dimensions.")
#         return False

#     # Check the range of values in t1
#     for row in t1:
#         if any(coef < 0 or coef > max_value for coef in row):
#             print("Error: t1 coefficients are out of the expected range [0, {}].".format(max_value))
#             return False

#     print("t1 is correctly formatted with all values within the expected range.")
#     return True

# # Example of invoking the check
# check_result = check_t1(t1)



# def check_t0(t0, q=8380417, d=13, rows_k=8, coefficients_per_polynomial=256):
#     # Calculate the maximum value for t0 coefficients
#     lower_bound = -2**(d-1) + 1
#     upper_bound = 2**(d-1)

#     # Check the shape of t0
#     if len(t0) != rows_k or any(len(row) != coefficients_per_polynomial for row in t0):
#         print("Error: t0 matrix does not have the correct dimensions.")
#         return False

#     # Check the range of values in t0
#     for row in t0:
#         if any(coef < lower_bound or coef > upper_bound for coef in row):
#             print(f"Error: t0 coefficients are out of the expected range [{lower_bound}, {upper_bound}].")
#             return False

#     print("t0 is correctly formatted with all values within the expected range.")
#     return True

# # Example of invoking the check
# check_result = check_t0(t0)

#---------------------------------------------------- STEP 7 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def simple_bit_pack(w, b):
    z = []
    for i in range(256):
        z = z + IntegerToBits(w[i], b)

    return bits_to_bytes(z)


#----------------------------------- pk_encode -----------------------------------#
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
def bytes_to_bits(z):
    y = []
    d = len(z)

    for i in range(d):
        for j in range(rows_k):
            y.append(z[i] % 2)  # Get the least significant bit
            z[i] //= 2  # Shift the byte right by 1 bit

    return y


# # #----------------------------------- Compute_tr -----------------------------------#
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
# def BitPack(w, a, b):
#     z = []  # Initialize an empty list to store bits

#     bitlen = math.ceil(math.log2(a + b))  # Compute bit length for (a + b)

#     for i in range(256):
#         z += IntegerToBits(b - w[i], bitlen)

#     byte_output = bits_to_bytes(z)
#     return byte_output 

def BitPack(w, a, b):
    z = []
    bitlen = math.ceil(math.log2(a + b))  # Compute bit length for (a + b)
    for i in range(256):
        z += IntegerToBits(b - w[i], bitlen)

    byte_output = bits_to_bytes(z)
    # print(f"BitPack output length: {len(byte_output)} bytes")  # Add this line to log the output length
    return byte_output



# def BitPack(w, a, b):
#     max_value = max(a, b)
#     bitlen = max_value.bit_length()  # Adjust bit length according to the max value possible
#     z = []
#     for value in w:
#         z += IntegerToBits(value, bitlen)
#     byte_output = bits_to_bytes(z)
#     print(f"BitPack output length: {len(byte_output)} bytes")  # Add this line to log the output length
#     return byte_output




#----------------------------------- sk_encode -----------------------------------#
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
# print(f"\nsk : {sk}") 


# expected_length = 4896  # From the calculation above
# actual_length = len(sk)
# print("Expected Length:", expected_length, "bytes")
# print("Actual Length:", actual_length, "bytes")
# print("Verification:", "Correct" if expected_length == actual_length else "Incorrect")