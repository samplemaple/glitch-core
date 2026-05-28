precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_intensity; // 0-1
uniform float u_block;     // 4-64
uniform int   u_seed;      // 1-999

float hash(vec2 p) {
  return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453 + float(u_seed) * 123.456);
}

void main() {
  vec2 uv = v_texCoord;
  vec2 blockUV = floor(uv * u_resolution / u_block);
  float h = hash(blockUV);

  if (h < u_intensity) {
    float dx = (hash(blockUV + 0.5) - 0.5) * 0.15;
    float dy = (hash(blockUV + 1.0) - 0.5) * 0.15;
    uv += vec2(dx, dy);
    uv = clamp(uv, 0.0, 1.0);
  }

  gl_FragColor = texture2D(u_texture, uv);
}
