precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_track;     // tracking noise (0-1)
uniform float u_noise;     // noise level (0-0.5)
uniform float u_bleed;     // color bleed (0-1)

float hash(vec2 p) {
  return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

void main() {
  vec2 uv = v_texCoord;
  float t = hash(vec2(floor(uv.y * u_resolution.y / 3.0), uv.y));
  float track = smoothstep(u_track - 0.05, u_track, t) * hash(vec2(t, uv.y)) * u_bleed;
  uv.x += track * 0.02;
  uv.x = clamp(uv.x, 0.0, 1.0);

  vec4 c = texture2D(u_texture, uv);
  float n = (hash(uv * u_resolution) - 0.5) * u_noise;
  c.rgb += n;
  c.r += track * 0.3 * c.r;
  c.b -= track * 0.2 * c.b;

  gl_FragColor = c;
}
