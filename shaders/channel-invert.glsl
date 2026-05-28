precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform int u_channel; // 0=all, 1=red only, 2=green only, 3=blue only

void main() {
  vec4 c = texture2D(u_texture, v_texCoord);

  if (u_channel == 0) {
    c.rgb = 1.0 - c.rgb;
  } else if (u_channel == 1) {
    c.r = 1.0 - c.r;
  } else if (u_channel == 2) {
    c.g = 1.0 - c.g;
  } else {
    c.b = 1.0 - c.b;
  }

  gl_FragColor = c;
}
