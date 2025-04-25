# core/ca.py

from . import dilithium_hw
from .node import Node


class CertificateAuthority(Node):
    def __init__(self):
        super().__init__("Certificate Authority")
        # Simulated Dilithium hardware key generation
        self.pk, self.sk = dilithium_hw.generate_keys()
        print("[CA] Keys generated")

    def node_type(self):
        return "CA"

    def sign_producer_pk(self, producer_pk):
        """
        Signs the producer's public key with the CA's secret key.
        """
        signed_pk = dilithium_hw.sign(producer_pk, self.sk)
        print(f"[CA] Signed producer PK: {signed_pk}")
        return signed_pk

    def verify_producer_pk(self, signed_producer_pk, producer_pk):
        """
        Verifies that the producer's public key was signed by the CA.
        """
        is_valid = dilithium_hw.verify(producer_pk, signed_producer_pk, self.pk)
        # print(f"[CA] Verifying producer PK: {is_valid}")
        return is_valid

    def get_public_key(self):
        return self.pk