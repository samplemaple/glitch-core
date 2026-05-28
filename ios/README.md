# glitch-core — iOS

Planned platform target. Not yet implemented.

## Target Architecture

```
AVFoundation (camera capture)
  → CVPixelBuffer
    → Metal (preferred) or GLES 2.0
      → glitch-core shaders (GLSL → MSL conversion)
        → AVAssetWriter (video) or UIImage (photo)
```

## Planned Features

- Real-time camera preview with effects (AVCaptureSession)
- Photo capture with effect chain
- Video processing pipeline
- Swift-friendly API via C bridge

## Key Design Decisions (TBD)

| Decision | Options | Status |
|----------|---------|:--:|
| Graphics API | Metal vs GLES | Metal preferred (Apple deprecating GLES) |
| Shader pipeline | GLSL → MSL offline conversion | Build-time script |
| Swift interop | C bridge + module map | Standard pattern |
| Effect chain | MTLRenderPassDescriptor ping-pong | Same logic as Web FBO chain |

## Metal Shader Conversion

iOS does not support GLSL natively (outside GLES compatibility layer).
Planned approach:

```
../shaders/pixel-sort.glsl  →  glslangValidator -S frag -V100
                              → SPIR-V
                              → SPIRV-Cross --msl
                              → pixel-sort.metal
```

## Status

📋 Planning phase. See repository [issues](https://github.com/samplemaple/glitch-core/issues)
for discussion and timeline.
