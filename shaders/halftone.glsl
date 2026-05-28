precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_size;      // dot size (2-30)
uniform float u_angle;     // degrees (0-90)
uniform int   u_type;      // 0=dots, 1=lines

float lum(vec3 c) {
  return dot(c, vec3(0.299, 0.587, 0.114));
}

void main() {
  vec2 uv = v_texCoord * u_resolution;
  float d;

  if (u_type == 0) {
    vec2 p = fract(uv / u_size) - 0.5;
    d = length(p) * 2.0;
  } else {
    float a = radians(u_angle);
    vec2 r = vec2(cos(a), sin(a));
    d = abs(fract(dot(uv, r) / u_size) - 0.5) * 2.0;
  }

  float l = lum(texture2D(u_texture, v_texCoord).rgb);
  float bw = 0.15 + 0.3 * (u_size / 30.0);
  float t = smoothstep(l - bw, l, 1.0 - d);

  gl_FragColor = vec4(vec3(t), 1.0);
}
