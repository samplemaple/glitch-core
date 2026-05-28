# Effect Specification — GlitchCore

This document is the canonical reference for all 19 glitch art effects.
Every platform implementation (WebGL, GLES, Metal, CPU fallback) must
conform to this spec.

## Shader Interface Contract

All fragment shaders share a common vertex shader (`common.vert`):

```glsl
// Fullscreen quad — passes normalized UV to fragment shader
attribute vec2 a_position;
varying vec2 v_texCoord;
```

Every fragment shader receives:

| Input | Type | Description |
|-------|------|-------------|
| `v_texCoord` | `vec2` | Normalized texture coordinate (0–1) |
| `u_texture` | `sampler2D` | Input image texture |
| `u_resolution` | `vec2` | Viewport size in pixels |
| `u_time` | `float` | Elapsed seconds (for animated effects) |
| Effect-specific uniforms | varies | See per-effect table below |

---

## Effect Catalog

### 1. Pixel Sort (`pixel-sort`)

Simulates data-bending by sorting pixels along rows or columns.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_intensity` | `float` | 0.5 | 0–1 | Sort strength |
| `u_threshold` | `float` | 0.45 | 0–1 | Luminance threshold for sort trigger |
| `u_direction` | `int` | 0 | {0,1} | 0=horizontal, 1=vertical |

### 2. RGB Shift (`rgb-shift`)

Classic chromatic aberration — offset red and blue channels.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_rOffset` | `vec2` | [12, 0] | -64–64 | Red channel x/y offset |
| `u_bOffset` | `vec2` | [-12, 0] | -64–64 | Blue channel x/y offset |

### 3. Scanlines (`scanlines`)

CRT-style horizontal line overlay.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_density` | `float` | 6 | 2–24 | Lines per screen height |
| `u_opacity` | `float` | 0.45 | 0–1 | Line visibility |
| `u_color` | `vec3` | [0, 1, 0.75] | — | Line color (RGB) |

### 4. Kaleidoscope (`kaleidoscope`)

Radial mirror symmetry effect.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_sides` | `float` | 6 | 2–16 | Number of mirror segments |
| `u_angle` | `float` | 0 | 0–2π | Rotation angle |
| `u_center` | `vec2` | [0.5, 0.5] | 0–1 | Mirror center point |

### 5. Wave (`wave`)

Sine-wave displacement in horizontal, vertical, or radial directions.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_amplitude` | `float` | 12 | 0–80 | Displacement strength in pixels |
| `u_frequency` | `float` | 8 | 1–32 | Wave frequency |
| `u_direction` | `int` | 0 | {0,1,2} | 0=horizontal, 1=vertical, 2=radial |

### 6. Mirror (`mirror`)

Reflective symmetry across axis or quadrants.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_mode` | `int` | 0 | {0,1,2} | 0=horizontal, 1=vertical, 2=quad |

### 7. Duotone (`duotone`)

Two-color posterization — maps luminance to highlight/shadow colors.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_highlight` | `vec3` | [0, 1, 0.75] | — | Highlight color (RGB) |
| `u_shadow` | `vec3` | [0.05, 0.02, 0.12] | — | Shadow color (RGB) |
| `u_blend` | `float` | 0.8 | 0–1 | Blend strength |

### 8. Channel Invert (`channel-invert`)

Invert specific color channels.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_channel` | `int` | 0 | {0,1,2,3} | 0=all, 1=red, 2=green, 3=blue |

### 9. Hue Shift (`hue-shift`)

Rotate hue in HSV color space with optional rainbow gradient.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_shift` | `float` | 0.2 | 0–1 | Hue rotation amount (normalized) |
| `u_rainbow` | `float` | 0.35 | 0–1 | Vertical rainbow gradient blend |

### 10. Grain (`grain`)

Film-grain noise overlay.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_intensity` | `float` | 0.25 | 0–1 | Noise strength |
| `u_size` | `float` | 3 | 0.5–10 | Grain particle size |
| `u_color` | `int` | 0 | {0,1} | 0=colored noise, 1=grayscale |

### 11. Halftone (`halftone`)

CMYK-style dot or line screen pattern.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_size` | `float` | 10 | 2–30 | Dot/line size |
| `u_angle` | `float` | 45 | 0–90 | Screen angle |
| `u_type` | `int` | 0 | {0,1} | 0=dots, 1=lines |

### 12. Pixelate (`pixelate`)

Blocky downsampling — retro game aesthetic.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_block` | `float` | 12 | 2–64 | Block size in pixels |

### 13. VHS (`vhs`)

VHS tape degradation: tracking errors, noise, color bleed.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_track` | `float` | 0.3 | 0–1 | Tracking distortion strength |
| `u_noise` | `float` | 0.12 | 0–0.5 | Static noise overlay |
| `u_bleed` | `float` | 0.45 | 0–1 | Chroma bleed intensity |

### 14. CRT (`crt`)

Full CRT monitor simulation: phosphor gaps, screen curvature, vignette.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_gap` | `float` | 3 | 1–8 | Phosphor gap width |
| `u_curve` | `float` | 0.08 | 0–0.3 | Screen curvature |
| `u_vignette` | `float` | 0.35 | 0–1 | Edge darkening |
| `u_dispersion` | `float` | 0.04 | 0–0.2 | Sub-pixel color dispersion |

### 15. 8-Bit (`8bit`)

Retro console palette quantization with optional pixelation.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_palette` | `int` | 0 | {0,1,2,3} | 0=CGA palette 1, 1=CGA palette 2, 2=EGA, 3=Game Boy |
| `u_pixelate` | `float` | 6 | 1–16 | Downsample block size |

### 16. Edge Detect (`edge-detect`)

Sobel-based edge detection with render modes.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_intensity` | `float` | 1.2 | 0–3 | Edge threshold |
| `u_mode` | `int` | 0 | {0,1,2} | 0=line art, 1=overlay, 2=edges only |

### 17. Brightness/Contrast/Saturation (`brightness`)

Classic image adjustment — BCS controls.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_brightness` | `float` | 0.05 | -0.5–0.5 | Brightness offset |
| `u_contrast` | `float` | 1.15 | 0.5–2 | Contrast multiplier |
| `u_saturation` | `float` | 1.1 | 0–2 | Saturation multiplier |

### 18. Data Glitch (`data-glitch`)

Simulated data corruption — random block displacement.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_intensity` | `float` | 0.45 | 0–1 | Corruption strength |
| `u_block` | `float` | 24 | 4–64 | Corrupted block size |
| `u_seed` | `float` | 137 | 1–999 | Random seed |

### 19. Stretch (`stretch`)

Linear pixel stretching — datamosh / slit-scan style.

| Uniform | Type | Default | Range | Description |
|---------|------|---------|-------|-------------|
| `u_intensity` | `float` | 0.4 | 0–1 | Stretch strength |
| `u_direction` | `int` | 0 | {0,1} | 0=horizontal, 1=vertical |

---

## Platform Implementation Notes

### Uniform Naming Convention

All uniforms use `u_` prefix. Platform wrappers map from the effect key
to uniform names. Example mapping:

```
effect: "pixelSort"
  → uniform "u_intensity" = params.intensity
  → uniform "u_threshold"  = params.threshold
  → uniform "u_direction"  = params.direction
```

### Precision Requirements

- Shaders use `precision mediump float` for mobile compatibility.
- All color uniforms are normalized 0–1 range.
- Coordinates are in normalized UV space (0–1).

### Animation Support

Effects marked with `u_time` uniform support real-time animation.
Current animated effects: VHS (noise evolution), CRT (phosphor decay),
Grain (noise seed rotation).
