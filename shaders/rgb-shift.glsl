precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform vec2 u_rOffset;  // red channel offset (px)
uniform vec2 u_bOffset;  // blue channel offset (px)

void main() {
  vec2 pixelSize = 1.0 / u_resolution;

  float r = texture2D(u_texture, v_texCoord + u_rOffset * pixelSize).r;
  float g = texture2D(u_texture, v_texCoord).g;
  float b = texture2D(u_texture, v_texCoord + u_bOffset * pixelSize).b;
  float a = texture2D(u_texture, v_texCoord).a;

  gl_FragColor = vec4(r, g, b, a);
}
