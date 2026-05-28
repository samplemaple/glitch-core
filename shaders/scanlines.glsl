precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_density;    // scanline spacing (px)
uniform float u_opacity;    // 0.0-1.0
uniform vec3 u_color;       // scanline color

void main() {
  vec4 texColor = texture2D(u_texture, v_texCoord);
  float lineY = v_texCoord.y * u_resolution.y;

  float line = step(0.5, mod(lineY, u_density) / u_density);
  vec3 blended = mix(texColor.rgb, u_color * texColor.rgb, line * u_opacity);

  gl_FragColor = vec4(blended, texColor.a);
}
