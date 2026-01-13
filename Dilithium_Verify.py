from Dilithium_Key import *
from Dilithium_Sign import *
import os

#---------------------------------------------------- STEP 1 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def SimpleBitUnpack(v, b):
    c = bitlen(b)
    z = BytesToBits(v)
    w = [] 

    for i in range(256):
        bits = z[i*c : (i+1)*c]
        w_i = BitsToInteger(bits, c) 
        w.append(w_i)
    return w


#----------------------------------- pkDecode -----------------------------------#
def pkDecode(pk):
    rho = pk[:32]
    t1 = []
    y = bitlen(q - 1)
    b = (2 ** (y - d)) - 1

    poly_size = (len(pk) - 32) // 8  
    for i in range(8):
        start = 32 + i * poly_size
        end = start + poly_size
        t1_i = SimpleBitUnpack(pk[start:end], b)  
        t1.append(t1_i)
    return rho, t1



#---------------------------------------------------- STEP 2 ----------------------------------------------------#
#----------------------------------- FUNCTIONS -----------------------------------#
def HintBitUnpack(y):
    h = [[0]*256 for _ in range(8)]  
    Index = 0  
    First = 0  

    for i in range(8):
        if y[omega + i] < Index or y[omega + i] > omega:  
            return None  
        First = Index
        while Index < y[omega + i]:
            if Index > First:
                if y[Index - 1] >= y[Index]: 
                    return None
            h[i][y[Index]] = 1
            Index += 1

    for i in range(Index, omega):
        if y[i] != 0:
            return None

    return h


#----------------------------------- sigDecode -----------------------------------#
def sigDecode(sigma):
    bl = 32 * (1 + int(gamma1 - 1).bit_length())  # block length for z elements
    cl = Lambda // 4  
    
    c_tilde = sigma[:cl]
    offset = cl

    z = []
    for i in range(cols_l):
        xi = sigma[offset: offset + bl]
        z.append(BitUnpack(xi, gamma1 - 1, gamma1))  
        offset += bl

    y = sigma[offset: offset + omega + rows_k]  
    h = HintBitUnpack(y)  

    return c_tilde, z, h



#---------------------------------------------------- STEP 9 ----------------------------------------------------#
#----------------------------------- compute_w_approx -----------------------------------#
def compute_w_approx(A, z, v_c, t1):
    z_ntt = []
    for i in range(len(z)):
        z_ntt.append(NTT(z[i]))
    # for i in range(len(z_ntt)):
    #     print(f"\nz_ntt[{i}] = {z_ntt[i]}")

    v_c_ntt = NTT(v_c)
    # print(f"\nv_c_ntt = {v_c_ntt}")

    t1_ntt = []
    for t1_i in t1:
        scaled_t1_i = []
        for coeff in t1_i:
            scaled_coeff = coeff * (2**d)  
            scaled_t1_i.append(scaled_coeff) 
        transformed_poly = NTT(scaled_t1_i)  
        t1_ntt.append(transformed_poly)
    # for i in range(len(t1_ntt)):
    #     print(f"\nt1_ntt[{i}] = {t1_ntt[i]}")
    
    Az_mul = []
    for _ in range(rows_k):
        vector = [0] * coefficients_per_polynomial
        Az_mul.append(vector)

    for i in range(len(A)):  
        for j in range(len(z_ntt)): 
            for k in range(256): 
                Az_mul[i][k] = (Az_mul[i][k] + (A[i][j][k] * z_ntt[j][k]) % q) % q

    # for i in range(rows_k):            
    #     print(f"\nAz_mul[{i}] = {', '.join(map(str, Az_mul[i]))}")


    c_t1_products = [[0] * 256 for _ in range(len(t1_ntt))]
    for i in range(len(t1_ntt)):
        for k in range(256):
            c_t1_products[i][k] = (v_c_ntt[k] * t1_ntt[i][k]) % q

    # for i in range(len(c_t1_products)):
    #     print(f"\nc_t1_products[{i}] = {c_t1_products[i]}")


    w_approx = []
    for i in range(len(t1)):
        final_poly = [(Az_mul[i][k] - c_t1_products[i][k]) % q for k in range(256)]
        w_approx.append(NTT_inverse(final_poly))

    return w_approx



#---------------------------------------------------- STEP 10 & 11 ----------------------------------------------------#
#----------------------------------- use_hint -----------------------------------#
def use_hint(h, r):
    m = (q - 1) // (2*gamma2)
    r1v = []
    for i in range(256):
        r1, r0 = Decompose(r[i])
        if h[i] == 1 and r0 > 0:
            r1 = (r1 + 1) % m
        if h[i] == 1 and r0 <= 0:
            r1 = (r1 - 1) % m
        r1v += [ r1 ]
    return r1v



#---------------------------------------------------- MAIN FUNCTION ----------------------------------------------------#
def Verify(pk_hex, M, sign_hex, ctx):
    pk = bytes.fromhex(pk_hex)
    sign = bytes.fromhex(sign_hex)


    if len(ctx) > 255:
        return False  

    M_prime = (IntegerToBytes(0, 1)) + (IntegerToBytes(len(ctx), 1)) + ctx + M

    # print(pk.hex())
    # print()
    # print(M_prime.hex())
    # print()
    # print(sign.hex())

    return Verify_internal(pk, M_prime, sign)  



#---------------------------------------------------- Verify_internal ----------------------------------------------------#
def Verify_internal(pk, M_prime, sign):
    # #--------  Step 1:
    rho, t1 = pkDecode(pk)
    # print(f"\nρ : {rho.hex()}")

    # for i in range(len(t1)):             
    #     print(f"\nt1[{i}] = [{', '.join(map(str, t1[i]))}]")


    # # #--------  Step 2:
    c_h, z, h = sigDecode(sign)
    # print(f"\nc_h : {c_h.hex()}") 

    # for index, poly in enumerate(z):
    #     print(f"\nz {index} = {poly}")

    # print("Hint Vector (h):")
    # for poly_index, hint_poly in enumerate(h):
    #     print(f"\nh[{poly_index}]: {hint_poly}")


    # # #--------  Step 3 & 4:
    # if h == 1:
    if h == None:
        return False


    # # #--------  Step 5:
    A = ExpandA(rho)
    # for i in range(rows_k):
    #     for j in range(cols_l):
    #         print(f"\nA[{i}][{j}] = {A[i][j].tolist()}")


    # # #--------  Step 6:
    tr = compute_tr(pk)
    # print(f"\ntr : {tr.hex()}") 


    # # #--------  Step 7:
    mu = compute_mu(tr, M_prime)
    # print(f"\nmu : {mu.hex()}") 


    # # #--------  Step 8:
    v_c = SampleInBall(c_h)
    # print(f"\nv_c : {v_c}") 


    # # #--------  Step 9:
    w_approx = compute_w_approx(A, z, v_c, t1)
    # for i, poly in enumerate(w_approx):
    #     print(f"\nw_approx[{i}] = [{', '.join(map(str, poly))}]")


    # # #--------  Step 10 & 11:
    w1 = []
    for i in range(len(h)):  #
        w1.append(use_hint(h[i], w_approx[i]))
    # for i, poly in enumerate(w1):
    #     print(f"w1[{i}] = {poly}")


    # # #--------  Step 12:
    w1_encoded = w1Encode(w1)
    # print(f"\nw1_enc : {w1_encoded.hex()}") 

    c_h_star = compute_commit_hash(mu, w1_encoded)
    # print(f"\nc_h_star : {c_h_star.hex()}")


    # # #--------  Step 13:
    ch_chstar_check = (c_h == c_h_star)
    return (compute_infinity_norm(z) < gamma1 - beta) and (ch_chstar_check)




# pk_hex = 'fd855f180ce4b9a7d537d35cc769b3d54559ed76d61dd027c35eb3c329584bec0f347f156792c8c039cb2bc3fed2e55decf7ea2b57e9d4b6390c606998d619d2c030a4796c5353b06be8781dc6f1d60351577945d943b0303dc7ac3231dddbeef1a67a0c67895795b9b609ebbfda3e62937d39a0b530e54e36a91f71712e6770a0986d7f05cd7256d92d5e24097578b5929c0d4fb1480c9b4450ac9ab78cf3df803ddc67db0c4fb5a53706ad306c6487a59a3d47a97ce7864c117058cb3f150c44eb6090e5f25fc4cd02d64ed5dea00dc89d40763dd1453a455cdd991da1f81400bdd77f3f7789c5179e10115d70440a2bc7aa79e232a2b81016db19974d689833c6d48c7d75a590a7b6a53f5d22b30754588eb394934a45dc21fa3ccab3b5204e063a19947cdaacde1ec91f243c9604cd5f7d75839903f9c42646869d4e13dea52fa939a7a8e80d0682351fe42dd4615ac1def0cd2cb400041e81d1c7c81058bbcd1182dd0e3c520caa009f187fdb9c32edc933dbc1c30048728d8daa9dc16e3ee8f58ea4ce9b6e4c99d8e8fb9a08e8487c1c52064e147bd944fe106b384fca5f7d68744e8b416d53b28b3ca99439a9bbd43df79ca5374e5527f6b6a2918fe7933074087b5d14e6657f15a25daa77f15c360a6a8693909fc08f8128e9b60fa14f4ea98f92882a8a16eb6d5ad6f9ad6c4e9cb290bfe30893ff0dbb8d91f119fd228aa9d235df0d435e6e65b6811144a0afc0717dc9a74946404d4dce96dbb10b79ad8f7d5bf216e7a4c959b62edc57e9de6d9877e3ddcb8e17787811e41e496e9bd806f5eed10dcc1af94c1051c09abd1af7d879ca1fe41025dac34127dfc4de2371217193fd81d67c5fe728799bece5af795e2e396d0f60411a8993c9f6f00d9212fa8297dd79e187bd0f24a3d30fc66fa069210376937137afa09c3cb2bfbfa4ef714df543bc29e5bbca020425a6a7b0a9dec9c71a3c83e3f347de2c13dafaa9256b1a05a6a9f43f88f2707809d0e1aab5318d7fac3ad06589501a9f068deda006b1a3ef34eb8a1dc418c7c8d7cd8e7ec96e25172b99844144e824eea7fcb5d2c0fde72bdda8783b7b627ea0870d63996e97cf84eabc61865fbe59c5b9c5735c835470f4eb3431ac5e71c70d4135d68a29937efa14f7409f18d15d4300a9d7d23b6fb401b40c8ef5ef92b35113b748cf83f3b6ee0f7d83fbd2eabfc0a179169847bcc5910c85ed83e0563b4423e41de58354480e9b381388e5eea0e319a772064437c4221f7356611a76b3768bff28f8cdf1a7a23dc33efefc0a74875cc853db48aa6b10016c991ab342e68a40c3d5668def03e8ccd3f0351f1903221ece978fff91e8ab4fb94fa5cda1368c65969bbb4933ec101cd0f665937450b11e679c4f860c6be173aa549d5071e430471a0e17b33318ecc2e590e07fa80c9bcfea68d3b67142abf17d4100a4ba12d01f87ee20f81545a47ea43e8d758450a54fecce50b1bb4a217966a7556dd4bea5a204e56569970963dddbf75f62994373daca33eb33aeea07db910b132759226e9629b5534f601be585459326cfd6b1da7864ff7e76924662b0869109b2532b38c78e73e071ff7d87b683ea156c0c9ecf420aebf8e7c5553c78b4dc6038babd317ab22ad16d45c63a162a7afc0f5a96f4608d13173b70c62a2f8d07396de2dcf89b1ac15f0fb8f425f4ec26959dad352ad4909f0e61db73f16a28f2c80aaaad62d4c38aaa518ada748a4a783d60e5405338a0837db40d91759afc10b4078af577fd3c4475e980ec27f9c926d0a5e24a02c713a892d47d785b70009b30e2b0baf0357b0b2f4c8ef026500662b4784a32b34284f9fdea5b59536c10a2025767fe92517e1c8f217496a630ef925436dcd039cc74cce0e76b46c4014ad04d09534dea803cf00b90bcb2b7cabb86de4e328deeea605f820390d9192aa51b76f403f69c14f62bdc52d9354c82153ef6355e52c76b7a23fac2938587ac4a87d5911fcf85d2a93faf3fcd8614c7131bff824553413f54f8a0b9c6e8e26234d78bcbf8d37d473dcfdec709e8985f5630fe19084ca331839c2a53ebcdce34eb0671c94115361e81c614b4c4bd385e53dc133839afb65d1233e871aafc5d4ed8fa0a280d4840ab482b19a193b1a107974bdc9926103183f1a58696cfde9ffeaef0c9c68ae3be4afc79df769fca36e95a058899bac54252dc817febb9d1441235fdfec045ee46ca8a254b955b31bc2dd8e7bb78aeff0b68381d224bb3dbc15bceec180e72bfa8d76c282e832aa62f47988b0e5fd538cb05b726d402834f8837c76e8c5e1360c1383518d9d9132a4d95cf16bc65d88744cd8db133ab36503b16f1fb2560f9b116209dab6ef2e010f10cfecb3bcd1ba940799ef28f77458f2b82b5c28f31829e63ccc4d93c51cd4c60b58dc443234d9988a1d40be3c45f2afcf032df193c90f0c1954478e43198c5b4bf90a2d3b24207bfbe4f8048ef3fb1b96ccd9349d9ef985a14150837cfe33a2a5c55f530c4e93a1254e54c0be396796656ee51ad9402accf9502566e2c3d8373da59ad06a414e71caeb57c8429b5469fea38fe38770777b0225947c1e14ff57029510342ee2499a703a1d82dbe6c448fd679a38ba80aff61cecbb02cc7e23ea5ccd0729562f220985ce6746e0182572ef8d826061af605d1fc3997a05c8a12b3681e5ad621874ad9b1a180d56e6b04acd8a20c52e9285b2d359f8caedc97fe63d851c9dc81303cb538c6e1e9aa970fe5521989020c8c0aaae14944be5b4b617ec7f257306d6202ef4d49921990132a21e283e5d6f5b5c21d92586ad48f4a48c77b658eb69bb16f26277da5f0c16dec9f302abada0b85c30db08411ec38725a2b28d9b8dcb372ab82b8e00b7d8a81a1f40403d0c38bda59d6f21963aaadbab817ebed7f6fe0239b653a3279b686f7d783b3f29737f271a58fa00c5e5cb32fe408847348692de40496c3074aff24334db9521bcbc48fec2559d9a991dae9b93637aeaae3fdca3cb4e70ff84a2499e53e71f8fea7cc71126de8c451f5c3c880f0216dbaa46b8c3036e7c283c7f4e6c410186be635eeaafcae8773181631e39c19055f52ebe1998257e6f05d4e37da0d7e1809676f10735ee22ef8d29e2f1dcf8a8266b82f125d666249ba71edad8d26f71fc4a5a8d25cc264a09ac81405d8dfecdfb3dee95a7dd56ce6f57543c3794059156e9ce2eefd01ccb08f3a7815ac6fbf4cde1d7faa38208bc042bc52eb587db32572a317e6b25d927c988ff3e0d910f9f40555e849d289b25024808ea39434ad639ea8e17b85ab4502fb1074361ae6931c8057dfbbd9c60c695c9a6763068168fa7c68dae4561920888e035206fc6884851644bf35da1289bdbd56b2f9f3392fa40699aab1770f06bbfc48a043e7632faa4bda86434548e9df4c670f9e127dee193c9a3c2a904e45e49080ab08a2ca4794ac6a01525b7a94010cba38f45fd490c1aa3cee2987fef8b25134cba4b2c2497063e1f207bb1acf43c443f9a9c8fecefdd2d86313d280eec51335b1d841546f0840419f7ab6c515a0e65ab6eae02cf75340648eca2f2a2315342e3b9696b395c7b9abaf3fd5b32c44df82323e787c1d8186729f5a255238a549a544bef00e178cbd644fe6e0dc5ee74b873e'
# pk = bytes.fromhex(pk_hex)

# m_hex = '5369676e6564206279204d4c5f445341a1bb7e05a5581d1e7ba7b0fd68b05a3c'
# M_prime = bytes.fromhex(m_hex)

# sig_hex = 'fa1798f5b13a9314edb1c3155b123ba265b31859497306af01466616a2f5c0cfaad6235d8d3e9ef377422fb92d060a349be97bc50e598b100fdf582a31bbafa01c872c8507260952957b20a263a8a4b66e3cd2bdd46ec0475f8d9a27ecf9111c0d07866654de4c72e856e2982a544d681533327824050309302e64f5eb9f13b74debba58fccdac40f4e5cc942df52f00ebe4a2ec071dd17b70a72df958e417e08e48193674b8fa31665529b89fea7406f152dd7daeb9da4e89b3a87136c9b5b3aaf10e3ae579ecc81c7ffecbaba084337b6851bd3344b946a67416fc596f73acad5625d161b9d06fff167d376843bfae10e8fedcea65ae37a9e77c32cfbc6541d44a372ca88008989d2a680ef9be7eb123bdca5903e6d5a7723104e02cce62452395759b82000dcac4cf3fc93babe4f4c2dce8d89e54aae6314d3e00164246079d2f2858333abc5ccb7e8eef38376fb5775d09d32908ba0fc25dfd732786aaf9bdb5c073e3ac0ba5df3f88a3613a9a6ae7fbdaaf14f90f81d5c64dd7cd226b81414025ec23a9ab549b23d4d84d5d21eaa33af723bffa6ac044afba88e52db39d8d3799e7f50dfe12240de7df029a7bc05c3a7edb5d111c36f2716b819c1667c2f7ad8cef0a83279f45a7f14ee48dd11c4aab78848240f8ef81960368890b309394f885622d5935c68656bc93d155f801910e1c1e21dfda8f897ebc11c05f75c0139a6323a1c0518ed626dad7d634f26b73b1f39677f76f08db980e79100f2dbd2b8d60fe261f8e029d2119622600a72773896111e3f9c73ae73b6f6871fe6ea446d5c86d6792a747b33dc2c70325fc8c9414dcf31ed70f4a114b64c9032f7bbc7da5b384663796bea8ffb0f81bb6e1a1df215bf1e1060350eb0c9d179b8d50fd38e2b69afd2df138137d9f775023c659028debb982134b48e04eb0f311f81dcf879b6441a47232d2bd0cb62129ab72796b89c78b519ad5214575effacd914a5c05446775fa46dec9e10ded5f7b7e99568ed9a5388530539c5083b021ef6067f8f96df6e229e8578ce861b9b4c56adba2a14bff871f2dbc5e7e73029adab7da65c0d8078923c51942db837b2e0d9fbd00e2ecf939d554551db2bc4a2a7b68c35167a43fa891516638709fcd10849b96ad1b7b32d740225459eb6a1f80867e49b0c5d2031c0c25eb9f49191ad33642f2bb701effeebb19a95b35f40f6b23e43e0c4f6aa5ca0183d95054dcd112fec81e8338cc318b51591b578b709434229c3fb1dd765935f1349b70e332fb7a40b8972a084a0eb6712a47b66b55b9e0dacb92e207db46532e908568d9eb5dbd5739efb0689e855f9665b12d1f5108527ca937fa8906138234215dd607c04d244c7d2f65a3790e4b510b860d44b52f861f3e3108d6d7235e2f3f012e6d7acdc76b663db747ca1cbf49439e4fa602e5814e54146e8730bc5306b1429735c5c809ba8d5723b2a9f4e7b6c903fa2e4e4184fd0161c46d435763662279b47d202ec5e37163989b055d817fbeb8ba218e5fb6638854ce8c4e22a90e63bd30f49b257fa9257be295a200edc8e54871a24cc06652a0679cb2ba0dfe515deb23f4617982ecf4175c3cbb4a8c2c5ba9ccc730f8d95b15bc7169975b13fcdcffc1477da1820480ef4320241d006e13e2431cc7aab83064647082e8fcccaf30d23ad5ef1f85e49549e3f8b32f73ce8fa748789eabd416fd11541d0a9963defb9ace73bb80d169eaad7ec681954b464643edbced01689f7e22a1053a86d7ef18961ac426946ec093596f7f17ae1f5352a4ca1ca32c7d13e36ae2f5fb0b4329cd47f7ba9f68fd90ff85c69c8d6cce973d3630bdf73d8252f2bd67686eedb0d8dc7608de6d764baa4021da8c6f70499a2b289bedbb3acdc121687bfec78644c19c6da78bb420db38cfa142cbbee67088189106b83fad44a02973277e13d8bcc8a9889a75bce259440422152e4f01f2303250060f7bab9313342d7c20c5b2bf71675096e667b60cef155b7cf7f895155384eb6735fa3f72647908f9689e41147b63a1c4b052adda081a76ffd589d52c2eb9890a3383eeafa18368c877263ed628a4b72f189776cbd98cccc949d3a2e0ae470a310d314a5b81ac5a89ceb4296783d0932f6c6bd679fd1b02492ec9145bc55a66403175b152d54c2273965548ba3f34e1b5d56cac6651c6f3c8047c7ca1b97fb2b29f2933cd1f58f28e97830d69b3341a8d31a3f39fc591a568b0b0603af80a28e44cc53c7ffaf81c8a2c3226e415433219e8533a49b79f12aab896ccca6b8a84b574fc14d5532f5aabb33d5e3d21765a6e65e14e79ddf0aa1fed420a94b4f02aa70e00cb051f71f2ddb3d3a4eb0d91ab3c6f98015d362f95ee643df8ffcda9c6d1d5cc42f73fb1895443d239a2a1eb12bb6885b228943a234cff4b456441f589ded4430c10257ce74ce5ebf06bdd5cfc37208a5eedb7b59daae41adcde75dc70e8e420eded14878a62c5b4f34de20af8e479c8781da7274228445afbaa6ba2be3eba420797314a2ee9cb70e6f1dbec36590c9cd84791155491586775bd1bfcd1898864594370507caa1b3f3be3792286789dc49c2f9e16fcf955de9c570712f7d739fe665cd7f10ffae7a1207b6a3706596e2110d62bc14450e68c7e926934a7b3f04d6ba5fa6a0ee0c93e236df165c0734662a555c15a35f5cd625c907782068f858285f5caa0d415fe70a8bd48f976e6727b3df7520f64ddff1beef35fe921d1ff0b8bae1bcd523e08c9da781f6122464e83bba11522b5bcd6805cc0699b61fb1f5574c7989cd3df271033c63ee2f78e92f57d4aae0c3f9e090412922e264b485702bf0dd8af17d60619f22d9836ce5576e1316dd5e0219297594cdaad5f784a0a758345b1c98e21411b297c256b9a1ff5fb40aae711d08bb96c49b6294c6c6c6de1f101912c07e97cb90b7a83b753ea02f67e2fc8bcaa222d35538a405795e0b66d67483dd9857b7861891d59140e11c562e50cfbf0ba33e60ff4c76213579f9ea504f6951b79a561637c789430f09795d938d50def44a00d4f73fd52da0ef16d2dbbf012cad55b0be0575aaeb431ac430a2087820c897ec09f7b3ff3f01bcf8e8d356abffabf855582511cbd06acdd931c9e6995aa0665375239d9e65dfb33be8c9c1e786c4eb110e93104234f265446111b0f2a1c4a137050dcc8dbef0805858166a438b44bde5af7d5837c03446c5f31017e4e4927622ef3d2750158e04a1735c911d4ac206e3c13ffe8ecb5d79d09f2742821b60389979a4ae8e10c3d34d9d7207cf652f304655c9366a9a2bf4d746eeaeff18eb98ff49d5ff20b9a247eb248269daa72ad81679ecc6495fc28e0a1a6635ba847d44df486a7e0973a3172e3eb8f1cbc43d30994dbe1791f050e3808367a0efcaa2db0caeea5ae55c47375bbc8c1c6498a9b4f201316660bb064fd06038130ef232181b6ab46679d7a10203386f49664bfb1d2eda8577859a48d04263cd36b26cf0b518cd533d7d524c25f4ff62e2014167483b31a76c6e172734a73b155b3ef07039bc79b5292b6723bf3649a977f34ce9f7d4c1053efdf8f48dd9c1e58ca6555d61bdf398f479f7d61935ec50fea389b4ede2087068e0d229d02ab03951462f38b51ff5a91a06cd5f4c4ea29e21dbec45daae80fddecb437da5fd81799b19f24934d9382248d956d210e404b33f864cc30e143d0556e4eb4e9bb44370c746f617c779f7d5317ede5782c195cae48761b269db3d7723a365c410984e483a6ccf3eb19b642dbe875243ca9fe4e9b49364777f6a8d9d50904aca30f066d514ec2dcef5ddc2bebfeaf0f201f89b61f2cc0bec5378b1ef1157d54daf174889243b008c79b975cfc15da83ac60ad12d64e9c7ed3dc495cbbbf80c59239b301c068c7b4cc0833f2a65b63ee7a9b5c09ef4fe07618b5f35fc831e6921d584e9e0448dc4488c40ee415c04dace1444aa723284be3cad2a102757e8e9f28540076efd96ffd61cfc4b6269b00b7535c4b9ba56975e1488b5e371fd19280410ccb9449172bac87a7794c89a34b2f1f18e49fd5794e72922f188e9dfeac2ba486d6cde75a2b7c4a2dfbae792a82203df4ddb5f73dfb248c3fa83ed4591540f0b07d524bf05eb70d16cd34782546d71f13b34787177ad03c14f233e8bb5a025ca6614dd6780f25a9fcf7dcbfcdae887665afccb76aa0f8c3c9e6757bb3947d9a7807ba15a0f157aa211f380a27dd841d71dfe48db1be4bed0a948a16f7f88346a2328367a7f1e4cd0ece3bba8d5b011d1fa95173be5804e12fc53dfab69c417ae9d5eb47b672b9779bedbf22f11f3704fed13860f02002e3bfdb9f07794fcc3d3828ed041b6fec571cd10dd37dfabddba553d103234d208ae5eeed8c7cdfe4259a18c5186cd5019a3436ed2981dd24bd472d92690db4a9a8c8302a7d1b7397ab0dcae8970d6afe62c152ab3393ad72a03965c5152efaa70e39f4fe82e213eb7a65c67e4cf6a07568d560a8dd4393fa7aa117056ada36ee88312641f9902346ed5c95e744651c1dd2b6b810ea6291d7f6cf04a7dc8754946d2776a7c8b804dfeeef5787aed0105ff08d0a6922ec08818b363e2b3de10c3e50ec5cfb9d793758ebd76c7ce3e9e9b845f8189fde12bff8c6bee278173c90d8395fd8d14e673a85e8dbe92ff53937bb7f7241055a950c8197d73017f7501d9be8409dbfc3d1d7f15fef7195b879146fca19451043e804de2e727bb9e9b38e4097a014e25572b7b3d76e95ee80f46064733dd6b6b9a1fa5909123f143f04214da0137a2e781e04532075d054c1bb2ac79dca6c83fc5cad22c5cfbc32518dc21dec78453cf31f3e3f89a9c6b3043eea8e7e0477eccdaeca8abfc734dab120de4af47bfe356bfecf0cf7d5b65039876c330317b407118aa59e9b521a854bdfb00eaec5f5c79f6c7e4cf618dc20fd0b9056535d3b81a25ce53c0d657ddca292212c75dde502f9d3374b4f0d4ff1f6ef48fab12a8d2ce9d996f156cfb54a94664d038015c465f67f3014bcf7cf66827fcea4e1bfc324c78e1733aa7a608524bc1bb29bcbb71750cc0a89848c040fcb09f946950aa35d3a65608aeb6d636511a43b5e2739c3665a6aa9a033cecc1851f7aafadda600961763163e3db22f0693eedc904548d986cb72fa48fb2ce8b35d0de2f6f190a4102cb9519ce24d7a46ca77098beefa334aced416ab042965c5bd5f7f9bcd2d8cad3f4b4a9d034a6c28ef437f3d6f283556213345bb92e2f874d818b1eb56ed530edac8be66c01f064abaa8de1a486599561e99adb925a1a3b57a25e3c847ebfedfd80190c7f4cb22eee1f829dc76e25a56dcabac8af67c121265d48e077e2c5f2c3d442f72e558de949f8daad5fef760400cb40dd119072948a126c6169c88c6110bfb76c8df94d3d174e42b0d60889e768c5e0deb600e0b363ccf28d438576cd6d3fa81c7cae573753005b66d9914ea98c601fec550324d3babdac5f08d15d8992347308d245008f6029924af481ef2cb351f5811b181faaafa66644eed31614b3f8456cd98fe5bbde6091e0936d17bacdcd59ad60ebdba45213c30bc9f3000b1bd72614af2c07c509a5d70cc731d9ca3764ad0329b890247864c916430a8c241f505be2f1f0197b1d51ca743283d3cbefd969a05b509d9a501011029ec9797e349909d5543e42a928a817345e1eda0e7e8b0b1044f5884e55c4c3a2ce86d7fab82fa3d45ec8a81904475734fff8b58fa2cd7ef67fbf0296d5bdf1c1a9a8fc58ab5d2d4f5fde6a2b359ac42b28d1e7662f27ef15577fe14090b08c686ce63b0536cef92d144d0178d7642f60d397333e0d372d300cfc4e1d3c18519270ba0647475bd718f013ac6711e9c07940c1a217ed134f844b4acfc58b1f1d7fc8aef27f8059cf106935276da4b024abb625b381163a8fa1d6498075c1073e04d49a7375951eb87becabd3cede81ca4917bc55fe57879a9bb663f595f8523bf810d00cc3c37fd593e937981ec068a0cc588c667c2efaf0139f2ed228fc81676aef94fec6db902de036772ba8519ff8afcc1b1fa1e202e0993ffe8568b86a529bb1b580efbddbf39b1d6047dc94a3b898fbafe1836a0cbc868e205d9d2a4b45bba9ff13d90bd9065e07e1bbd956adb75973e4585c1ab363a289d50072ba8478ec5354ab24049ed3ac2cd71f3a31418b5cef157e4dd7351ddf51602f735555bf3016be99bd6378da1f4d9bb06781947a4bd25f53f96b75b986063a9347a1dbfaf197ec319a145e01c7ccc4f05457e7e29f1377c40748f3dc3f96d1117f5c97f42f1227e57bb62997d3b74d51bf1ea9dfedcb1604f6e00775b1fd94f707250de3316f2a7957ebccf9a4e77a036b7a3423f90acdd175e192d952ca070efdb19b50e268442aa8ad97dd047db014e72b994569103bb2b3a61e5fd031d2948aeef04424877788190d8fb0435535b76c6c7d9ebf7010b184a5a94c1c8ec2b4f5e617a8cadb6c6f44890d8606d7dc600000000000000000000000000000000000000050b141e27313438'
# sign = bytes.fromhex(sig_hex)

# # ctx_h = '0f0e462d1e3ec1d3ac4f177f65804ef20dc904e1df8a344f4e62710f81e71b58433aa964ff8d633cfc117fedb642d16768af61e56f11a97db900e593393c5827bcedb5c7deef12cae71dc7809c216bb74f675ca994713e07fb592042758cf0643dbe4c86555ddd5b479ff1fedb3c3a3f6b32fbff1ce83384a9ba7c1165cfffdb'
# # ctx = bytes.fromhex(ctx_h)

# # ctx = b''

# ctx = os.urandom(128)
# print(ctx.hex())


# verification = Verify(pk, M_prime, sign, ctx)
# print("Verification Result:", verification)
