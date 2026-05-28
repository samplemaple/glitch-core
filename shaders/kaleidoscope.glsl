precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_sides;     // number of sides (2-16)
uniform float u_angle;     // rotation angle (0-6.28)
uniform vec2 u_center;     // center point (0-1)

void main() {
  vec2 uv = v_texCoord - u_center;
  float a = atan(uv.y, uv.x) + u_angle;
  float r = length(uv);
  float seg = 3.14159 * 2.0 / u_sides;
  a = mod(a, seg);
  a = min(a, seg - a);
  uv = r * vec2(cos(a), sin(a));
  uv += u_center;
  uv = clamp(uv, 0.0, 1.0);
  gl_FragColor = texture2D(u_texture, uv);
}
