void proportion(inout vec2 st) {
  st.x *= iResolution.x/iResolution.y;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ) {
  vec2 uv = fragCoord.xy/iResolution.xy;
  proportion(uv);
  vec3 color = vec3(1.,1.,1.);


  fragColor = vec4(color,1.);
}