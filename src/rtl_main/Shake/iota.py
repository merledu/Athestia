import numpy as np

def rc(t):
    if t % 255 == 0:
        return 1

    # Initialize R as the bit sequence "10000000" which is 0b10000000 in binary
    R = [1, 0, 0, 0, 0, 0, 0, 0]

    for i in range(1, t % 255):
        # Step a: Shift R right by one position (prepend a 0 to R)
        R = [0] + R

        # Ensure R is still 9 bits (truncate the last bit)
        if len(R) > 9:
            R = R[:9]

        # Step b-f: Perform XOR operations
        R[0] ^= R[8]
        R[4] ^= R[8]
        R[5] ^= R[8]
        R[6] ^= R[8]

        # Step f: Truncate R to 8 bits (the last bit is discarded)
        R = R[:8]

    # Return R[0] (the first bit)
    return R[0]


def iota(A, ir):
    # Step 1: Copy A to A_prime
    A_prime = np.copy(A)

    # Step 2: Initialize RC as an array of w bits (64 bits here, so 0w)
    w = 64
    RC = np.zeros(w, dtype=np.uint64)  # Ensure RC is uint64 to match A's dtype

    # Step 3: Set RC[2j - 1] = rc(j + 7 * ir) for j in range 0 to l
    # Since w = 64, l is w // 2 = 32
    for j in range(1, w // 2 + 1):
        RC[2 * j - 1] = np.uint64(rc(j + 7 * ir))  # Ensure we cast the result to uint64

    # Step 4: XOR RC with A_prime[0, 0, z] for all z in range 0 to w
    for z in range(w):
        A_prime[0, 0, z] ^= RC[z]  # A_prime and RC are now both uint64

    # Step 5: Return the updated state array A_prime
    return A_prime[0][0]


import numpy as np

def rho(A):
    x_size, y_size, z_size = A.shape
    assert x_size == 5 and y_size == 5 and z_size == 64, "Input array must have shape (5, 5, 64)"
    
    # Step 1: Initialize A′
    A_prime = np.zeros_like(A, dtype=np.uint8)
    for z in range(z_size):
        A_prime[0, 0, z] = A[0, 0, z]
    
    # Step 2: Initialize (x, y)
    x, y = 1, 0
    
    # Step 3: Apply the transformation
    for t in range(24):
        for z in range(z_size):
            index = (z - (t + 1) * (t + 2) // 2) % z_size
            A_prime[x, y, z] = A[x, y, index]
        
        # Update (x, y)
        x, y = y, (2 * x + 3 * y) % 5
    
    return A_prime

# Example usage:



# Example usage:
values = [
    [
        '0111111011011010101101000101111000010111110011100000100110000011', 
        '1110011100110110111011000011001111101110000000111110110011011110', 
        '0010001100100010010111110001001100011000110001001000101100001000', 
        '0111011100111110110000110010010010011100010010000100011011110111', 
        '0010011001001011010100100011111011100000011111110111111110011000'
    ],
    [
        '0100000010010000111110111010011010010000111101111111010100100000', 
        '1000000101001011010100001010110101110110011001100100110010011010', 
        '1101110111001001001101011110010101100111001001110110001110001111', 
        '0111111101000111111111000100011000110101000111010101100001100101', 
        '0110110000111110000000111111100000011010111000110100000010010011'
    ],
    [
        '1001111011110100100100000011001111111010001101110000111010000000', 
        '1001111100001100111110001010000010110110101100110000111001111001', 
        '1001010110000010100010010111110110010111110101011000011001111100', 
        '0010010100100001011001011110100111011111101000101010000100101001', 
        '1001101111010011011011101010000000001110001101110011000010110101'
    ],
    [
        '1011110101000010100111101110011101100100110010001111110101010101', 
        '0101000100111110110101111101011110111100011000111001000000110000', 
        '0111110000111110001000101111000111000001110001010111101100100010', 
        '0101110101110000000111111100111011010111010110001000001000101101', 
        '0000111100101110110111100011101001100101011011100010010010011000'
    ],
    [
        '1011110101000010100111101110011101100100110010001111110101010101', 
        '0101000100111110110101111101011110111100011000111001000000110000', 
        '0111110000111110001000101111000111000001110001010111101100100010', 
        '0101110101110000000111111100111011010111010110001000001000101101', 
        '0000111100101110110111100011101001100101011011100010010010011000'
    ]
]

# Convert binary strings to integers
def binary_to_int(binary_str):
    return int(binary_str, 2)

# Initialize the array A
A = np.array([[list(map(binary_to_int, row)) for row in layer] for layer in values], dtype=np.uint64)
ir = 1  # Example round index
# print(iota(A, ir))
print(rho(A)[0][0])
