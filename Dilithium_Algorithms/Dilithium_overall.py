import os
import pickle
from Dilithium_Key import *
from Dilithium_Sign import *
from Dilithium_Verify import *

random_bytes = os.urandom


def set_drbg_seed(seed):
    """
    Set DRBG seed to switch from os.urandom to deterministic AES256-CTR-DRBG.
    """
    global random_bytes
    try:
        from drbg.aes256_ctr_drbg import AES256_CTR_DRBG
        drbg = AES256_CTR_DRBG(seed)
        random_bytes = drbg.random_bytes
    except ImportError as e:
        print(f"Error importing AES from pycryptodome: {e}")
        raise Warning("Install missing dependencies: pip install pycryptodome")

def generate_keypair():
    zeta = random_bytes(32)
    # print(len(zeta))
    pk, sk = KeyGen(zeta)
    pk_hex = pk.hex()
    sk_hex = sk.hex()
    return {
        'pk': pk_hex,
        'sk': sk_hex
    }

def sign(sk_hex, msg_hex, rnd, ctx):
    sig = Sign(sk_hex, msg_hex, rnd, ctx)
    return {
        'signature': sig.hex()   
    }

def verify(pk_hex, msg_hex, sig_hex, ctx):
    return Verify(pk_hex, msg_hex, sig_hex, ctx)



msg = b"Signed by ML_DSA" + os.urandom(16)
# print("message", msg.hex())

ctx = os.urandom(128)
# print("ctx", ctx.hex())

keypair = generate_keypair()
pk = keypair['pk']
sk = keypair['sk']
# print("Public Key:", pk)
# print("secret Key:", sk)

# Generate random nonce for signing
rnd = random_bytes(32)

# Sign the message
signature_dict = sign(sk, msg, rnd, ctx)
sig = signature_dict['signature']
# print("Signature:", sig)

# Verify the signature
result = verify(pk, msg, sig, ctx)
print("Verification Result:", result)