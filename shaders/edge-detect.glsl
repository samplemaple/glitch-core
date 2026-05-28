precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D u_texture;
uniform vec2 u_resolution;
uniform float u_intensity; // 0-3
uniform int   u_mode;      // 0=sobel line art, 1=overlay, 2=edges only

float lum(vec3 c) {
  return dot(c, vec3(0.299, 0.587, 0.114));
}

void main() {
  vec2 ps = 1.0 / u_resolution;

  // Edge guard: fallback within 1px of border
  if (v_texCoord.x < ps.x || v_texCoord.x > 1.0 - ps.x ||
      v_texCoord.y < ps.y || v_texCoord.y > 1.0 - ps.y) {
    gl_FragColor = texture2D(u_texture, v_texCoord);
    return;
  }

  float tl = lum(texture2D(u_texture, v_texCoord + vec2(-ps.x, ps.y)).rgb);
  float t  = lum(texture2D(u_texture, v_texCoord + vec2(0, ps.y)).rgb);
  float tr = lum(texture2D(u_texture, v_texCoord + vec2(ps.x, ps.y)).rgb);
  float l  = lum(texture2D(u_texture, v_texCoord + vec2(-ps.x, 0)).rgb);
  float r  = lum(texture2D(u_texture, v_texCoord + vec2(ps.x, 0)).rgb);
  float bl = lum(texture2D(u_texture, v_texCoord + vec2(-ps.x, -ps.y)).rgb);
  float b  = lum(texture2D(u_texture, v_texCoord + vec2(0, -ps.y)).rgb);
  float br = lum(texture2D(u_texture, v_texCoord + vec2(ps.x, -ps.y)).rgb);

  float gx = -tl - 2.0 * l - bl + tr + 2.0 * r + br;
  float gy = -tl - 2.0 * t - tr + bl + 2.0 * b + br;
  float edge = sqrt(gx * gx + gy * gy) * u_intensity;

  if (u_mode == 0) {
    gl_FragColor = vec4(vec3(1.0 - edge), 1.0);
  } else if (u_mode == 1) {
    vec4 orig = texture2D(u_texture, v_texCoord);
    gl_FragColor = vec4(mix(orig.rgb, vec3(0), edge * 0.8), orig.a);
  } else {
    gl_FragColor = vec4(vec3(edge), 1.0);
  }
}
