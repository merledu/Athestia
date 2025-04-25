# core/packet.py

class InterestPacket:
    """
    Interest Packet in NDN requesting data for a given name.
    """
    def __init__(self, name):
        self.type = "interest"
        self.name = name

    def to_dict(self):
        return {
            "type": self.type,
            "name": self.name
        }

    def __str__(self):
        return f"[InterestPacket] name: {self.name}"


class DataPacket:
    """
    Data Packet in NDN containing content, signature, and keys.
    """
    def __init__(self, name, data, signature, producer_pk, signed_producer_pk):
        self.type = "data"
        self.name = name
        self.data = data
        self.signature = signature
        self.producer_pk = producer_pk
        self.signed_producer_pk = signed_producer_pk

    def to_dict(self):
        return {
            "type": self.type,
            "name": self.name,
            "data": self.data,
            "signature": self.signature,
            "producer_pk": self.producer_pk,
            "signed_producer_pk": self.signed_producer_pk
        }

    def __str__(self):
        return (
            f"[DataPacket] name: {self.name}, data: {self.data}, "
            f"signature: {self.signature}, pk: {self.producer_pk}"
        )