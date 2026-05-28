# glitch-core — Android

Planned platform target. Not yet implemented.

## Target Architecture

```
Camera2 / CameraX
  → SurfaceTexture (OES texture)
    → GLES 2.0 / 3.0 context
      → glitch-core shaders (from ../shaders/)
        → MediaCodec (video) or Bitmap (photo)
```

## Planned Features

- Real-time camera preview with effects
- Photo mode: capture → apply effect chain → save
- Video mode: per-frame GLES processing → MediaCodec encode
- JNI bridge for Kotlin/Java API

## Key Design Decisions (TBD)

| Decision | Options | Status |
|----------|---------|:--:|
| Camera API | CameraX vs Camera2 | Camera2 preferred (predictable frame timing) |
| GLES version | 2.0 vs 3.0 | 2.0 for max compatibility, opt-in 3.0 features |
| Effect chain | FBO ping-pong | Same pattern as Web demos |
| Uniform upload | JNI direct buffer | Performance requirement |

## Dependencies (planned)

- Android NDK (C99 + CMake)
- OpenGL ES 2.0 headers
- No third-party graphics libraries

## Status

📋 Planning phase. See repository [issues](https://github.com/samplemaple/glitch-core/issues)
for discussion and timeline.
