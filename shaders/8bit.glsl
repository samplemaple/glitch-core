precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform int   u_palette;   // 0=CGA1, 1=CGA2, 2=EGA, 3=GameBoy
uniform float u_pixelate;  // block size (1-16)

vec3 pal(float l, int p) {
  if (p == 0) {
    if (l < 0.33) return vec3(0, 0, 0);
    if (l < 0.66) return vec3(0, 1, 1);
    return vec3(1, 0, 1);
  }
  if (p == 1) {
    if (l < 0.33) return vec3(0, 0, 0);
    if (l < 0.66) return vec3(1, 0, 0);
    return vec3(0, 1, 0);
  }
  if (p == 2) {
    float i = floor(l * 15.0 + 0.5);
    float b = mod(i, 2.0);
    float g = mod(floor(i / 2.0), 2.0);
    float r = mod(floor(i / 4.0), 2.0);
    return vec3(r, g, b) * 0.67 + 0.33;
  }
  // Game Boy: 4-level green
  float gb = l * 0.5 + 0.2;
  return vec3(gb * 0.2, gb * 0.7, gb * 0.1);
}

void main() {
  vec2 uv = v_texCoord;
  uv = floor(uv * u_resolution / u_pixelate) * u_pixelate / u_resolution + u_pixelate / u_resolution * 0.5;
  vec4 c = texture2D(u_texture, uv);
  float l = dot(c.rgb, vec3(0.299, 0.587, 0.114));
  gl_FragColor = vec4(pal(l, u_palette), 1.0);
}
