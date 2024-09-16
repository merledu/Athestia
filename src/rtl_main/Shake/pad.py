def pad10_1(x, m):
    # Step 1: Calculate j = (-m - 2) % x
    j = (-m - 2) % x

    # Step 2: Create the string P = "1" + "0" * j + "1"
    P = "1" + "0" * j + "1"
    
    # Return the result
    return P

# Example usage:
x = 8
m = 0
result = pad10_1(x, m)
print(result)  # Output will be "10001" for x=5 and m=3
