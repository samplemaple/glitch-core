# glitch-core

> Cross-platform glitch art shader core — 19 GLSL effects.
> MIT licensed. Use anywhere.

## What is this?

A collection of 19 production-grade GLSL fragment shaders for real-time
glitch art effects — pixel sorting, RGB shift, scanlines, VHS, CRT,
data corruption, and more.

Built for **[GlitchForge](https://glitchforge.pages.dev)** —
a free online glitch art tool. This repo is the shader engine
extracted for use on any platform.

## Effects

| # | Effect | Key | Animated |
|---|--------|-----|:--:|
| 1 | Pixel Sort | `pixel-sort` | |
| 2 | RGB Shift | `rgb-shift` | |
| 3 | Scanlines | `scanlines` | |
| 4 | Kaleidoscope | `kaleidoscope` | |
| 5 | Wave | `wave` | |
| 6 | Mirror | `mirror` | |
| 7 | Duotone | `duotone` | |
| 8 | Channel Invert | `channel-invert` | |
| 9 | Hue Shift | `hue-shift` | |
| 10 | Grain | `grain` | ✅ |
| 11 | Halftone | `halftone` | |
| 12 | Pixelate | `pixelate` | |
| 13 | VHS | `vhs` | ✅ |
| 14 | CRT | `crt` | ✅ |
| 15 | 8-Bit | `8bit` | |
| 16 | Edge Detect | `edge-detect` | |
| 17 | Brightness/Contrast/Saturation | `brightness` | |
| 18 | Data Glitch | `data-glitch` | |
| 19 | Stretch | `stretch` | |

## Quick Start

```bash
git clone https://github.com/samplemaple/glitch-core.git
cd glitch-core/web/demos
# Open any .html file in a browser — no build step, no server needed
open 01-pixel-sort-rgb-shift-scanlines.html
```

Each demo is a standalone HTML file with embedded WebGL boilerplate.
Upload an image, toggle effects, adjust sliders — instant preview.

## Repo Structure

```
glitch-core/
├── shaders/          ← 19 GLSL fragment shaders + 1 vertex shader
│                      Platform-agnostic. Used by every target below.
├── SPEC.md           ← Canonical effect spec — uniforms, types, ranges
├── web/              ← Platform: Web
│   ├── README.md
│   └── demos/        ← 6 standalone HTML demos (open in browser)
├── android/          ← Platform: Android (GLES2/GLES3)
├── ios/              ← Platform: iOS (Metal/GLES)
└── cli/              ← Platform: CLI / headless (CPU fallback)
```

**One folder per platform.** Add a new folder when you add a new target.

## Platform Support

| Platform | Status | Backend |
|----------|:------:|---------|
| Web (browser) | ✅ demos ready | WebGL 1.0 |
| Web (GlitchForge) | ✅ [live](https://glitchforge.pages.dev) | WebGL + Next.js |
| Android | 📋 planned | GLES 2.0 / GLES 3.0 |
| iOS | 📋 planned | Metal / GLES |
| CLI / Server | 📋 planned | Headless GL / CPU fallback |

## Architecture

```
                    ┌──────────────────────┐
                    │    shaders/*.glsl     │
                    │   (single source)     │
                    └──────┬───────────────┘
                           │
          ┌────────────────┼────────────────┐
          │                │                │
     ┌────▼────┐     ┌────▼────┐     ┌─────▼─────┐
     │   Web   │     │ Android │     │    iOS    │
     │ WebGL   │     │  GLES   │     │  Metal    │
     └─────────┘     └─────────┘     └───────────┘
```

All platforms share the same GLSL shaders.
Platform wrappers handle texture I/O, context management,
and uniform binding — but the visual logic lives here.

## License

MIT — use it in open-source projects, commercial products,
mobile apps, CLI tools. No attribution required (but appreciated).

---

**Built with ❤️ by [GlitchForge](https://glitchforge.pages.dev)**
— Free online glitch art, no watermarks, full resolution.
