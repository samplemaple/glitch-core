precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_intensity;   // 0.0-1.0
uniform float u_threshold;   // 0.0-1.0 brightness threshold
uniform float u_direction;   // 0=horizontal, 1=vertical

float luminance(vec3 c) {
  return dot(c, vec3(0.299, 0.587, 0.114));
}

void main() {
  vec2 uv = v_texCoord;
  float sortRange = u_intensity * 0.6;
  float threshold = u_threshold;

  if (sortRange < 0.001 || u_intensity < 0.01) {
    gl_FragColor = texture2D(u_texture, uv);
    return;
  }

  vec4 original = texture2D(u_texture, uv);
  float origLum = luminance(original.rgb);

  if (origLum < threshold - 0.06) {
    gl_FragColor = original;
    return;
  }

  float maxLum = origLum;
  vec4 bestColor = original;

  for (int i = 0; i < 8; i++) {
    float t = (float(i) / 7.0 - 0.5) * sortRange;
    vec2 sampleUV = uv;
    if (u_direction < 0.5) sampleUV.x += t;
    else sampleUV.y += t;
    sampleUV = clamp(sampleUV, 0.0, 1.0);
    vec4 s = texture2D(u_texture, sampleUV);
    float sl = luminance(s.rgb);
    if (sl > maxLum) {
      maxLum = sl;
      bestColor = s;
    }
  }

  float blend = smoothstep(threshold - 0.05, threshold + 0.05, origLum) * u_intensity;
  gl_FragColor = mix(original, bestColor, blend);
}
