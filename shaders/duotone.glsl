precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform vec3 u_highlight;  // highlight color
uniform vec3 u_shadow;     // shadow color
uniform float u_blend;     // 0.0-1.0 mix with original

float lum(vec3 c) {
  return dot(c, vec3(0.299, 0.587, 0.114));
}

void main() {
  vec4 c = texture2D(u_texture, v_texCoord);
  float l = lum(c.rgb);
  vec3 duotone = mix(u_shadow, u_highlight, l);
  gl_FragColor = vec4(mix(c.rgb, duotone, u_blend), c.a);
}
