class PolynomialDilithiumProcessor:
    def __init__(self):
        self.q = 8380417
        self.n = 256
        self.root_of_unity = 1753
        self.ntt_zetas = [pow(self.root_of_unity, self._bit_reversal(i, 8), self.q) for i in range(self.n)]
        self.ntt_f = pow(self.n, -1, self.q)

    def _bit_reversal(self, i, k):
        """
        Bit reversal of an unsigned k-bit integer.
        """
        bin_i = bin(i & (2 ** k - 1))[2:].zfill(k)
        return int(bin_i[::-1], 2)

    def _parse_coefficients(self, coefficients):
        """
        Helper function which right pads with zeros
        to allow polynomial construction as f = R([1,1,1])
        """
        l = len(coefficients)
        if l > self.n:
            raise ValueError(
                f"Coefficients describe polynomial of degree greater than maximum degree {self.n}"
            )
        elif l < self.n:
            coefficients = coefficients + [0 for _ in range(self.n - l)]
        return coefficients

    def to_ntt(self, coefficients):
        """
        Convert a polynomial to number-theoretic transform (NTT).
        """
        coefficients = self._parse_coefficients(coefficients)
        k, l = 0, self.n // 2
        zetas = self.ntt_zetas
        while l > 0:
            start = 0
            while start < self.n:
                k += 1
                zeta = zetas[k]
                for j in range(start, start + l):
                    t = zeta * coefficients[j + l]
                    coefficients[j + l] = (coefficients[j] - t) % self.q
                    coefficients[j] = (coefficients[j] + t) % self.q
                start = l + (j + 1)
            l >>= 1
        return coefficients

    def from_ntt(self, coefficients):
        """
        Convert a polynomial from number-theoretic transform (NTT) form in place.
        The input is in bit-reversed order, the output is in standard order.
        """
        coefficients = self._parse_coefficients(coefficients)
        l, k = 1, self.n
        zetas = self.ntt_zetas
        while l < self.n:
            start = 0
            while start < self.n:
                k -= 1
                zeta = -zetas[k]
                for j in range(start, start + l):
                    t = coefficients[j]
                    coefficients[j] = (t + coefficients[j + l]) % self.q
                    coefficients[j + l] = (zeta * (t - coefficients[j + l])) % self.q
                start = j + l + 1
            l <<= 1
        for j in range(self.n):
            coefficients[j] = (coefficients[j] * self.ntt_f) % self.q
        return coefficients

# Example usage:
input_array = [
    5856639, 4304791, 3621534, 3332297, 5140260, 7365035, 7676299, 7203009, 6280886,
    5745764, 6777682, 6843725, 1637626, 219442, 834047, 7882345, 4206842, 2913330,
    5415133, 4684709, 6805479, 3437008, 6727739, 1854342, 7247641, 5117890, 4904358,
    2143709, 2863063, 1335793, 5048081, 5855728, 489846, 229392, 6384537, 8317947,
    1105673, 4969072, 1087723, 2491490, 5570157, 7520980, 4703022, 6332725, 7412984,
    856244, 249451, 3600284, 5814849, 6796024, 1693681, 5764213, 6645898, 4996761,
    7242176, 7741873, 498144, 7691632, 2248314, 1099686, 7062536, 4649968, 7507543,
    4355030, 6582476, 3038105, 1672149, 7131575, 8344263, 6545712, 8375947, 2753419,
    4770820, 284498, 6687151, 710510, 74810, 3847114, 3696491, 6334409, 7853033,
    109694, 5925416, 7420599, 5193960, 3234544, 1567670, 4436437, 4561560, 5597432,
    1095329, 6016530, 4657729, 6804480, 2522544, 8305041, 221664, 4244504, 2495963,
    520376, 6755054, 5121672, 6912811, 2345918, 777019, 5679361, 3413036, 6405996,
    3558619, 6488831, 807098, 5785498, 6597726, 3540519, 1210504, 6334712, 7708216,
    6875553, 1942473, 3581691, 2880530, 5004331, 1071512, 7578068, 4685901, 5654790,
    10246, 1439752, 4305784, 138784, 7262050, 219887, 4395429, 2928855, 227146,
    7133022, 2840407, 5470949, 4528403, 6309343, 2373183, 6922754, 200851, 6129899,
    2022348, 879996, 3927630, 4042428, 6658760, 3407393, 1229755, 4260713, 7569572,
    4359392, 5867443, 1362852, 6762955, 971064, 748011, 3037482, 1519550, 7210012,
    2699378, 8217955, 6180144, 2956493, 3222263, 8096107, 4510251, 7055015, 7215348,
    570558, 7867995, 8270996, 5732190, 7529485, 3447364, 2783240, 811297, 6043124,
    6066546, 2729509, 783393, 4284314, 4288095, 6391065, 5591944, 5598153, 1093981,
    3380100, 4456310, 1926349, 2693381, 6487044, 340786, 382711, 4126446, 6762777,
    1061536, 1387669, 6049364, 7742136, 8219384, 1568662, 4087751, 5626742, 6387953,
    1858908, 4447173, 4149235, 1714933, 5560905, 7586040, 5188346, 5920621, 3978674,
    5688363, 349687, 1200621, 5286116, 2554685, 6454562, 340321, 4537136, 1542380,
    5231158, 8008787, 2801029, 3710655, 497021, 1341626, 5662038, 4226353, 1421278,
    4198240, 4063468, 8316135, 4698967, 443614, 637204, 6852218, 4131843, 4535916,
    5628646, 5200257, 3847812, 4710141, 4185309, 6938311, 3952156, 5554884, 6267833,
    3611470, 378685, 2167649, 1572535
]


# print("\nInput array:", input_array)

processor = PolynomialDilithiumProcessor()

ntt_coeffs = processor.to_ntt(input_array)
# print("\nNTT Coefficients:", ntt_coeffs)

invntt_coeffs = processor.from_ntt(ntt_coeffs)
# print("\nOriginal Coefficients:", invntt_coeffs)
