# glitch-core — Web

Shader integration guide for browser / WebGL targets.

## Demos

The `demos/` directory contains 6 standalone HTML files.
Each is self-contained — zero dependencies, zero build step.

| File | Effects |
|------|---------|
| `01-pixel-sort-rgb-shift-scanlines.html` | Pixel Sort, RGB Shift, Scanlines |
| `02-kaleidoscope-wave-mirror.html` | Kaleidoscope, Wave, Mirror |
| `03-duotone-channel-hue.html` | Duotone, Channel Invert, Hue Shift |
| `04-grain-halftone-pixelate.html` | Grain, Halftone, Pixelate |
| `05-vhs-crt-8bit.html` | VHS, CRT, 8-Bit |
| `06-edge-bcs-data-stretch.html` | Edge Detect, BCS, Data Glitch, Stretch |

Open any `.html` file directly in a browser — upload an image,
toggle effects, and see real-time WebGL rendering.

## Using shaders in your own WebGL project

```js
// 1. Load shader source (bundler or fetch)
import pixelSortSrc from 'glitch-core/shaders/pixel-sort.glsl';

// 2. Compile
const vs = compileShader(gl, gl.VERTEX_SHADER, commonVertSrc);
const fs = compileShader(gl, gl.FRAGMENT_SHADER, pixelSortSrc);

// 3. Set uniforms
gl.uniform1f(loc.u_intensity, 0.5);
gl.uniform1f(loc.u_threshold, 0.45);
gl.uniform1i(loc.u_direction, 0);

// 4. Draw fullscreen quad
gl.drawArrays(gl.TRIANGLES, 0, 6);
```

See `demos/` for complete working examples including texture upload,
FBO ping-pong for effect chains, and uniform binding.

## Integration with GlitchForge

The production Web tool at [glitchforge.pages.dev](https://glitchforge.pages.dev)
uses these exact shaders with a WebGL compositor, FBO chain, and
React/Next.js UI. This repo is the extracted engine — the Web tool
is a consumer, not the source of truth.

## Requirements

- WebGL 1.0 (available in all modern browsers)
- No external dependencies
- Works on mobile browsers (iOS Safari, Android Chrome)
