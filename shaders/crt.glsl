precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_gap;         // pixel gap (1-8)
uniform float u_curve;       // curvature (0-0.3)
uniform float u_vignette;    // vignette intensity (0-1)
uniform float u_dispersion;  // chromatic dispersion (0-0.2)

void main() {
  vec2 uv = v_texCoord;
  vec2 d = uv - 0.5;
  float r = length(d);
  float safeCurve = min(u_curve, 0.25);
  uv = d * (1.0 - safeCurve * r * r) + 0.5;

  if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    return;
  }

  float rVal = texture2D(u_texture, uv + vec2(u_dispersion, 0.0)).r;
  float gVal = texture2D(u_texture, uv).g;
  float bVal = texture2D(u_texture, uv + vec2(-u_dispersion, 0.0)).b;

  float mask = mod(uv.y * u_resolution.y, u_gap * 3.0) < u_gap ? 1.0 : 0.4;
  vec3 col = vec3(rVal, gVal, bVal) * mask;
  col *= 1.0 - u_vignette * r * 2.0;

  gl_FragColor = vec4(col, 1.0);
}
