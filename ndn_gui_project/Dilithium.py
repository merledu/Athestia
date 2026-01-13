import os
import pickle
from Key import *
from Sign import *
from Verify import *
import time


random_bytes = os.urandom
ctx = os.urandom(128)
rnd = random_bytes(32)

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


def generate_keypair(id_prefix):
    zeta = random_bytes(32)
    pk, sk = KeyGen(zeta)
    pk_hex = pk.hex()
    sk_hex = sk.hex()
    return {
        'pk': pk_hex,
        'sk': sk_hex,
        'pk_id': f"{id_prefix}1",
        'sk_id': f"{id_prefix}2"
    }

def sign(sk_hex, msg_hex, id_prefix):
    sig = Sign(sk_hex, msg_hex, rnd, ctx)
    return {
        'signature': sig.hex(),
        'sig_id': f"{id_prefix}3"
    }

def verify(pk_hex, msg_hex, sig_hex):
    return Verify(pk_hex, msg_hex, sig_hex, ctx)
