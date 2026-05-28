precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform int u_mode; // 0=horizontal, 1=vertical, 2=quad

void main() {
  vec2 uv = v_texCoord;

  if (u_mode == 0) {
    uv.x = uv.x < 0.5 ? uv.x : 1.0 - uv.x;
  } else if (u_mode == 1) {
    uv.y = uv.y < 0.5 ? uv.y : 1.0 - uv.y;
  } else {
    uv.x = uv.x < 0.5 ? uv.x : 1.0 - uv.x;
    uv.y = uv.y < 0.5 ? uv.y : 1.0 - uv.y;
  }

  gl_FragColor = texture2D(u_texture, uv);
}
