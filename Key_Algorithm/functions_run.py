q = 8380417
rows_k = 8
cols_l = 7
coefficients_per_polynomial = 256
eta = 2
η = 2
d = 13


#---------------------------------------------------- KEY ----------------------------------------------------#
def IntegerToBytes(x, α):
    y = bytearray(α) 
    x_prime = x

    for i in range(α):
        y[i] = x_prime % 256
        x_prime = x_prime // 256
    return bytes(y)

x = 56758491223782255116706065660090661450792979282557094739072532684472550750973
α = 32 
byte_string = IntegerToBytes(x, α)
# print("Byte string:", byte_string)



import math 
def bits_to_bytes(y):                                                       
    alpha = len(y)
    z = [0] * math.ceil(alpha / 8)   #The byte string has a length of ⌈alpha/8⌉, math.ceil() method rounds a number to the nearest integer

    for i in range(alpha):
        z[i // 8] += y[i] * (2 ** (i % 8))   #Adds the bit y[i] to the appropriate position in the byte string z. The byte index is ⌊i/8⌋, 
                                             #and y[i] is multiplied by 2^(i mod 8) to shift the bit into the correct position within the byte.
    return bytes(z)  

y = [1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1]  # Example bit string
z = bits_to_bytes(y)
# print(z)



def IntegerToBits(x, α):
    x_prime = x
    y = [0] * α 

    for i in range(α):
        y[i] = x_prime % 2  #This operation extracts the least significant bit (LSB) of x. Modulo gives remainder
        x_prime = x_prime // 2    #This operation effectively moves to the next bit in x. (equivalent to a right shift). Division gives quotient 
    return y
x = 29  
alpha = 8  # Number of bits (we want 8 bits in this example)
bit_string = IntegerToBits(x, alpha)
# print("Bit string:", bit_string)



def BitsToInteger(y, α):
    x = 0
    for i in range(1, α+1):
        x = 2*x + y[α - i]  # Access the bit in little-endian order
    return x

# Example usage:
bit_string = [1, 0, 1, 1]  # Represents the bit string 1101 (in little-endian order)
length = len(bit_string)    # Length of the bit string
result = BitsToInteger(bit_string, length)
# print(f"The integer value of the bit string {bit_string} is: {result}")



def BitRev8(m):
    b = IntegerToBits(m, 8)
    brev = [0] * 8

    for i in range(8):
        brev[i] = b[7 - i]  # Reverse the order of bits

    # Step 6: Convert the reversed bit array back to an integer
    r = BitsToInteger(brev, 8)

    return r

m = 13  # For example, the byte '13' in binary is '00001101'
result = BitRev8(m)
# print(f"Original byte: {m} -> Reversed byte: {result}")


def montgomery_reduce(a):
    QINV = 58728449  
    t = ((a % (2**32)) * QINV) % (2**32)
    r = (a - t * q) // (2**32)
    return r



def bitlen(x):     # Calculate the bit length of a positive integer x using a loop
    length = 0
    while x > 0:
        x = x // 2
        length += 1
    return length

x = 32
bits = bitlen(x)
# print("Bits:", bits)



def SimpleBitPack(w, b):
    z = []
    for i in range(256):  # Since w has 256 coefficients
        # Step 3: z ← z || IntegerToBits(w_i, bitlen b)
        z += IntegerToBits(w[i], bitlen(b))  # Append bit representation of w_i to z

    return bits_to_bytes(z)

# Example usage:
w = [751, 696, 553, 528, 433, 345, 628, 679, 154, 549, 0, 699, 915, 79, 259, 621, 364, 127, 652, 142, 722, 638, 794, 311, 690, 644, 593, 61, 345, 375, 409, 968, 661, 51, 741, 335, 887, 65, 312, 376, 719, 557, 38, 820, 242, 767, 177, 445, 516, 6, 786, 192, 11, 500, 953, 677, 632, 89, 300, 418, 863, 116, 449, 528, 94, 493, 677, 739, 33, 66, 669, 761, 836, 621, 160, 828, 899, 326, 181, 895, 724, 905, 242, 280, 666, 613, 37, 663, 194, 507, 563, 1006, 67, 350, 903, 330, 661, 883, 301, 115, 662, 565, 142, 660, 248, 345, 211, 368, 692, 695, 940, 578, 386, 958, 863, 442, 12, 154, 633, 906, 441, 94, 886, 729, 543, 869, 926, 9, 122, 518, 631, 340, 287, 612, 1005, 428, 857, 646, 826, 172, 186, 449, 736, 1018, 322, 755, 267, 60, 535, 805, 566, 238, 376, 109, 988, 648, 121, 151, 223, 703, 47, 853, 659, 413, 95, 270, 103, 996, 758, 609, 915, 1012, 616, 531, 88, 372, 512, 427, 630, 672, 370, 197, 713, 769, 911, 985, 485, 392, 952, 748, 63, 734, 229, 544, 584, 421, 173, 372, 257, 979, 860, 279, 335, 64, 304, 526, 35, 198, 778, 1010, 666, 789, 181, 439, 573, 507, 459, 601, 255, 770, 792, 885, 64, 515, 214, 212, 541, 916, 910, 726, 50, 333, 682, 70, 264, 663, 346, 485, 589, 610, 506, 180, 358, 275, 869, 595, 36, 300, 519, 145, 476, 251, 337, 726, 813, 269]
y = bitlen(q - 1)
b = (2 ** (y - d)) - 1
# print(b)
print()
# b = math.ceil(math.log2(q - 1)) - d
encoded_bytes = SimpleBitPack(w, b)
# print(encoded_bytes)

expected_length = 32 * bitlen(b)
# print("Expected length:", expected_length)
# print("Actual length:", len(encoded_bytes))



def BitPack(w, a, b):
    z = []

    for i in range(256):
        z += IntegerToBits(b - w[i], bitlen(a+b))   #subtracts each coefficient wi from b, converting it to a non-negative integer in the range [0,a+b]

    byte_output = bits_to_bytes(z)
    return byte_output

w = [-1, -2, -2, 2, 1, -1, 2, -2, -2, 2, 2, 2, 0, 2, -2, 0, -1, -2, 0, 2, -2, -2, -1, -1, -1, 0, 0, 2, 1, -2, 1, -1, 2, -2, 0, 1, 1, 0, -1, 2, 1, -2, 0, 0, 0, 0, 1, -2, -1, -2, 2, 0, 0, -1, 1, 1, 0, -2, 2, 0, 1, -2, 1, 0, -2, -1, -2, 2, -1, -1, 0, -1, 1, 0, 0, 1, 2, 1, -2, 2, 0, -2, -2, 1, 1, 1, 0, -1, 0, -1, 2, 0, 1, 1, 1, 0, 2, 2, 1, 2, 1, -1, 1, 1, 0, 0, 0, -2, -2, 2, 0, 2, 1, -2, 0, 1, 1, 1, 1, 0, 1, -1, -2, 2, 0, 1, 2, -1, -2, -1, 1, 0, 2, -1, 1, 0, 2, 2, 2, -1, -1, 1, -1, 1, -2, -2, 0, -2, 1, -2, 0, -1, 2, 2, 0, -2, 1, -1, -1, 0, -2, -1, 1, -1, -2, 1, 2, 2, -1, -2, 2, 2, -1, -1, -2, 1, -1, 0, 2, -2, -2, -1, 2, -1, 0, -1, -1, 0, 0, 1, 2, 2, 1, 2, -2, 2, -2, 0, -2, -2, 0, -1, 1, 0, 0, -1, -2, 1, 0, 0, -1, 2, -2, 0, 0, -2, 2, 2, -2, -1, -2, -2, 0, 0, 2, -1, -2, -1, -2, 0, 0, 1, 2, -1, 0, -2, 2, -2, 0, -1, 1, 0, -1, 1, -2, -2, 2, -2, 0, -2, -1, 2, -1, -1, 1, 0]
a = 2
b = 2
encoded_bytes = BitPack(w, a, b)
# print(encoded_bytes)
expected_length = 32 * bitlen(a+b)
# print("Expected length:", expected_length)
# print("Actual length:", len(encoded_bytes))