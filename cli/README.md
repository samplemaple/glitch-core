# glitch-core — CLI

Planned platform target. Not yet implemented.

## Target Architecture

```
Input image (PNG/JPG/WebP)
  → CPU decode (stb_image or libpng)
    → Option A: Headless GL (EGL/OSMesa)
    → Option B: CPU fallback (pure C pixel processing)
  → Output image (PNG/JPG/WebP)
```

## Use Cases

- Batch processing (CI/CD, asset pipeline)
- Server-side rendering (API endpoint)
- WASM build for browser-based SDK
- Benchmarking / regression testing

## Key Design Decisions (TBD)

| Decision | Options | Status |
|----------|---------|:--:|
| Render backend | EGL headless vs CPU fallback | GPU preferred, CPU as fallback |
| CPU fallback | Start with simplified effects vs full parity | Tier-based capability |
| Image I/O | stb_image vs libpng/libjpeg | stb for simplicity |
| WASM target | Emscripten GLES → WebGL | Aligns with Web platform |

## CPU Fallback Strategy

Per the `GlitchCPU.capabilities` grading:

- **Tier 1**: Full pixel-level effects (mirror, channel invert, BCS)
- **Tier 2**: Block-based effects with fixed kernel (pixelate, halftone)
- **Tier 3**: Complex effects requiring per-pixel random access (pixel sort, data glitch)

The CPU renderer reports capabilities so callers can degrade gracefully.

## Status

📋 Planning phase. See repository [issues](https://github.com/samplemaple/glitch-core/issues)
for discussion and timeline.
