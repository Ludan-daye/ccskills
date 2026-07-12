"""SlabQuant fixture implementation (fake, for skill testing only)."""
import numpy as np

SLAB_SIZE = 64          # tokens per slab
BITS = 4
QMAX = 2 ** BITS - 1
CLIP_Q = 0.999          # (no comment anywhere about why this exists)


class SlabQuantCache:
    """KV cache stored as sealed 4-bit slabs plus one fp16 open buffer."""

    def __init__(self, head_dim):
        self.open_k, self.open_v = [], []
        self.sealed = []            # list of (codes_k, scale_k, zero_k, codes_v, scale_v, zero_v)
        self.head_dim = head_dim

    def append(self, k_vec, v_vec):
        # Mechanism 1: slab partitioning — accumulate fp16 until SLAB_SIZE, then seal.
        self.open_k.append(k_vec)
        self.open_v.append(v_vec)
        if len(self.open_k) == SLAB_SIZE:
            self.sealed.append(self._seal(np.array(self.open_k), np.array(self.open_v)))
            self.open_k, self.open_v = [], []

    def _seal(self, K, V):
        # Mechanism 2: per-slab affine quantization from the slab's own statistics.
        return (*_quantize(K), *_quantize(V))

    def read_all(self):
        # Mechanism 3: dequantize sealed slabs on read; open buffer stays fp16.
        outs = [(_dequantize(ck, sk, zk), _dequantize(cv, sv, zv))
                for (ck, sk, zk, cv, sv, zv) in self.sealed]
        return outs, (np.array(self.open_k), np.array(self.open_v))


def _quantize(X):
    lo = np.quantile(X, 1 - CLIP_Q)
    hi = np.quantile(X, CLIP_Q)     # range from clipped quantiles, not raw min/max
    X = np.clip(X, lo, hi)
    scale = (hi - lo) / QMAX
    zero = np.round(-lo / scale)
    codes = np.clip(np.round(X / scale) + zero, 0, QMAX).astype(np.uint8)
    return codes, np.float16(scale), np.float16(zero)


def _dequantize(codes, scale, zero):
    return (codes.astype(np.float32) - np.float32(zero)) * np.float32(scale)
