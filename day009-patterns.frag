void remap(inout vec2 st) {
  st = st/.5 - 1.;
}

void proportion(inout vec2 st) {
  st.x *= iResolution.x/iResolution.y;
}



void mainImage(out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord;
    remap(uv);
    proportion(uv);

    fragColor = vec4(vec3(.5,.0,.1),1.);
}