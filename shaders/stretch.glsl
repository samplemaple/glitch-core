precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_intensity; // 0-1
uniform int   u_direction; // 0=horizontal, 1=vertical

void main() {
  vec2 uv = v_texCoord;

  if (u_direction == 0) {
    float band = floor(uv.y * u_resolution.y / 8.0);
    float off = (fract(sin(band * 127.1) * 43758.54) - 0.5) * u_intensity * 0.05;
    uv.x += off;
  } else {
    float band = floor(uv.x * u_resolution.x / 8.0);
    float off = (fract(sin(band * 311.7) * 43758.54) - 0.5) * u_intensity * 0.05;
    uv.y += off;
  }

  uv = clamp(uv, 0.0, 1.0);
  gl_FragColor = texture2D(u_texture, uv);
}
