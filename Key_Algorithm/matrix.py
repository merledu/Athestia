import numpy as np

import numpy as np

# Initialize a 3D array of zeros with shape (2, 2, 256)
A = np.zeros((2, 2, 256), dtype=np.int64)

# Fill the A matrix with random integer values, for example between 0 and 10000
A = np.random.randint(0, 10000, (2, 2, 256), dtype=np.int64)

# Print the contents of A
for i in range(2):
    for j in range(2):
        print(f"\nA[{i}][{j}] = {A[i][j].tolist()}")
