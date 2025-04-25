# core/dilithium_hw.py
from core.key import *
from core.sign import *
from Cryptodome.Hash import SHAKE256
import os


def generate_keys():
    """
    Simulates Dilithium key generation.
    Returns (public_key, secret_key)
    """
    public_key,secret_key = KeyGen()
    
    return public_key.hex(), secret_key.hex()


def sign(data, secret_key):
    """
    Simulates Dilithium signing.
    Returns signature (shake256 hash of data + sk).
    """
    h = SHAKE256.new()
    h.update(data.encode('utf-8') + bytes.fromhex(secret_key))
    return h.read(32).hex()


def verify(data, signature, public_key):
    """
    Simulates verification.
    Note: This just matches against a recomputed signature (simulation only).
    """
    h = SHAKE256.new()
    # Fake it: use public_key as if it were sk for recomputation (simulation purpose)
    h.update(data.encode('utf-8') + bytes.fromhex(public_key))
    expected_sig = h.read(32).hex()
    return expected_sig == signature
