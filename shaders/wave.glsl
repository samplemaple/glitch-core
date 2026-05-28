precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_amplitude; // px
uniform float u_frequency; // waves across image
uniform int   u_direction; // 0=horizontal, 1=vertical, 2=radial

void main() {
  vec2 uv = v_texCoord;
  float amp = u_amplitude / u_resolution.x;
  float freq = u_frequency * 6.28318;
  float offset = 0.0;

  if (u_direction == 0) {
    offset = sin(uv.y * freq) * amp;
  } else if (u_direction == 1) {
    offset = sin(uv.x * freq) * amp;
  } else {
    float d = length(uv - 0.5);
    offset = sin(d * freq) * amp;
  }

  uv.x += offset;
  uv = clamp(uv, 0.0, 1.0);
  gl_FragColor = texture2D(u_texture, uv);
}
