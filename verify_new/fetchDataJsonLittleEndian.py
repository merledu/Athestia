import json

# Load JSON from file
with open("VerifyT/internalProjection.json", "r") as f:
    data = json.load(f)

# Convert hex string to little-endian hex (byte-wise reverse)
def to_little_endian_hex(label, hex_str):
    if not hex_str:
        print(f"{label} = <empty or missing>")
        return
    try:
        # Pad with a leading 0 if needed to make full bytes
        if len(hex_str) % 2 != 0:
            hex_str = '0' + hex_str

        # Reverse bytes for little-endian
        bytes_list = [hex_str[i:i+2] for i in range(0, len(hex_str), 2)]
        reversed_bytes = ''.join(reversed(bytes_list))

        value_int = int(reversed_bytes, 16)
        bit_length = len(bytes_list) * 8
        print(f"{label} = {bit_length}'h{value_int:0{bit_length // 4}X};")
    except ValueError:
        print(f"{label} = <invalid hex: {hex_str}>")

# Process only tgId == 5
for group in data.get("testGroups", []):
    if group.get("tgId") == 5:
        for test in group.get("tests", []):
            print(f"\n// tcId = {test.get('tcId')}")
            to_little_endian_hex("ctx", test.get("context", ""))
            to_little_endian_hex("pk", test.get("pk", ""))
            to_little_endian_hex("M", test.get("message", ""))
            to_little_endian_hex("sigma", test.get("signature", ""))
