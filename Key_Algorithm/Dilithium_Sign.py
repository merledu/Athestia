from Dilithium_Key import *

gamma_1 = 524288

def BytesToBits(z):
    alpha = len(z) 
    y = [0] * (8 * alpha) 
    
    z_prime = list(z)
    
    for i in range(alpha):
        for j in range(8):
            y[8 * i + j] = z_prime[i] % 2
            z_prime[i] = z_prime[i] // 2
    return y


def BitUnpack(v, a, b):
    """Unpacks the byte string v into polynomial w."""
    c = bitlen(a + b)
    z = BytesToBits(v)
    w = [0] * 256

    total_bits = len(z)
    
    for i in range(256):
        start = i * c
        end = (i + 1) * c
        
        if start >= total_bits:
            # No bits, out of loop
            break
        
        coefficient_bits = z[start:end]
        if coefficient_bits == [0]:
            break
        w[i] = b - BitsToInteger(coefficient_bits, c)
    
    return w

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
        t0.append(BitUnpack(w[i], eta, d))

    return rho, K, tr, s1, s2, t0

def H(input_data, output_length):
    """Hash function H based on SHAKE256."""
    shake = SHAKE256.new()
    shake.update(input_data)
    return shake.read(output_length)

def ExpandMask(rho, mu, l):
    """ExpandMask function based on NIST MLDSA Algorithm 34.
    
    Args:
        rho (bytes): Seed of length 64 bits (8 bytes).
        mu (int): Nonnegative integer.
        l (int): The length of output vector y.
        gamma1 (int): Bound for polynomial coefficients, a power of 2.
    
    Returns:
        list: Vector y where each entry is a polynomial with coefficients in range -gamma1+1 to gamma1.
    """
    c = 1 + bitlen(gamma_1 - 1)
    y = []

    for r in range(l):
        rho_prime = rho + IntegerToBytes(mu + r, 2)
        v = H(rho_prime, 32 * c)
        y_r = BitUnpack(v, gamma_1 - 1, gamma_1)
        y.append(y_r)

    return y

def ML_DSA_Sign_internal(sk, M_prime, rnd):
    
    rho, K, tr, s1, s2, t0 = skDecode(sk)
    
    # Step 2:
    s1_ntt = []
    for i in range(len(s1)):
        s1_ntt.append(NTT(s1[i]))
    
    # Step 3: 
    s2_ntt = []
    for i in range(len(s2)):
        s1_ntt.append(NTT(s2[i]))
    
    # Step 4:
    t0_ntt = []
    for i in range(len(t0)):
        s1_ntt.append(NTT(t0[i]))
    
    # Step 5: 
    A = ExpandA(rho)
    
    # Step 6: 
    mu_input = tr + bits_to_bytes(M_prime)
    mu = H(mu_input, 64)
    
    # Step 7:
    rho_double_prime_input = K + rnd + mu
    rho_double_prime = H(rho_double_prime_input, 64)
    
    # Step 8: 
    kappa = 0
    
    # Step 9: 
    z, h = None, None

    # Step 11:
    y = ExpandMask(rho_double_prime, kappa, l=len(s1))
    y_ntt = [NTT(poly) for poly in y]
    Aw_pointwise = []
    for i in range(len(A)):
        Aw_pointwise.append([(A[i][j] * y_ntt[i][j]) % q for j in range(256)])

    #step 12:
    w = [NTT_inverse(poly) for poly in Aw_pointwise]


    return w



M_prime = [1,0,1] 

rnd = b'\x01\x02\x03\x04\x05\x06\x07\x08' 

sk = b'm7\x8a\xd2\xe4z\x0c\x99n7\xd5,U\xcd\xa6{\xcc\xa6\xff\x8f\x1d,\xd6d9\xa8Sk\xb6\x84\xe2\x0f\xe3\x0f\x04\xb0\xa1\xa1E\x9fm\x97\x05K\xbbUx\x80\x144I\xb1\xcaP\xf5\x01\xe9\xe6)\xd5\x9d\xa73k\x8f\xa4>\x90%\xa8\xc9\x18.\xa6\x95\\g\xf8nu9\x90e\xea\xcc\xe4}@\xc2y\xb1Y\xa2\x05\xaaO"\x01\x06\xc4\n!\x01\xc3\x116\x9b^0\x97:\x99?\xb5.\x1e\'\x9f\r\\\xd9 ;\x12H\xcfl\xe1\x84\r\x08\x06\x08\x9c\xa8\x8d#3f\x0b\xa7pY\x82h\xd0\x06\x89\x1c\x18\x92\xc48n@\x92\x01\x8b"a 51\x848\x92\x89H@\x187\x0c`\xa0\x01\x1a\xc5@\x00\xa3\x10\x02\xa0)\x12\xc1i#\x00B\xd1\x92`B\x18\x06A\x16b\x0cE1\x19IB\x822\x8eHD\x82 \xb8\x10\x04\x89A\x0b\x96\x11\x0b\xa9\x0cX\xc0mP\x840\x1a&A@\xb6\x0e'

signature_result = ML_DSA_Sign_internal(sk, M_prime, rnd)
print(signature_result)

