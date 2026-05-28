precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_brightness; // -0.5 to 0.5
uniform float u_contrast;   // 0.5 to 2
uniform float u_saturation; // 0 to 2

vec3 adjustSaturation(vec3 c, float s) {
  float l = dot(c, vec3(0.2126, 0.7152, 0.0722));
  return mix(vec3(l), c, s);
}

void main() {
  vec4 c = texture2D(u_texture, v_texCoord);
  c.rgb += u_brightness;
  c.rgb = (c.rgb - 0.5) * u_contrast + 0.5;
  c.rgb = adjustSaturation(c.rgb, u_saturation);
  gl_FragColor = c;
}
