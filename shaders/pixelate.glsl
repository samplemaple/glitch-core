precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_block; // pixel block size (2-64)

void main() {
  vec2 uv = v_texCoord;
  uv = floor(uv * u_resolution / u_block) * u_block / u_resolution + u_block / u_resolution * 0.5;
  gl_FragColor = texture2D(u_texture, uv);
}
