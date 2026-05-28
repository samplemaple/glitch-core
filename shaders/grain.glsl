precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_intensity; // 0-1
uniform float u_size;      // grain size (0.5-10)
uniform int   u_color;     // 0=color, 1=grayscale

float hash(vec2 p) {
  return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
  vec4 c = texture2D(u_texture, v_texCoord);
  float n = hash(v_texCoord * u_resolution / u_size);

  if (u_color == 0) {
    c.rgb += vec3(
      hash(v_texCoord + 0.1) - 0.5,
      hash(v_texCoord + 0.2) - 0.5,
      hash(v_texCoord + 0.3) - 0.5
    ) * u_intensity;
  } else {
    float g = (n - 0.5) * u_intensity;
    c.rgb += g;
  }

  gl_FragColor = c;
}
