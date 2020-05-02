
void remap(inout vec2 st) {
  st = st/.5 - 1.;
}

void proportion(inout vec2 st) {
  st.x *= iResolution.x/iResolution.y;
}

vec2 tile (vec2 _st, float _zoom) {
    _st *= _zoom;
    // _st.x += step(1.0, mod(_st.y,2.0)) * iTime;
    // _st.x -= step(1., mod(-_st.y,2.0)) * iTime;
    float even_time = step(1.0, mod(iTime,2.0)) * iTime;
    float even_time_d = step(1.0, mod(iTime/2.,2.0)) * 2. -1.;
    float odd_time = step(1.0, mod(-iTime,2.0)) * iTime;
    float odd_time_d = step(1.0, mod(-iTime/2.,2.0)) * 2. -1.;
    _st.y += step(1.0, mod(_st.x,2.0)) * even_time * even_time_d;
    _st.y -= step(1.0, mod(-_st.x,2.0)) * even_time * even_time_d;
    _st.x += step(1.0, mod(_st.y,2.0)) * odd_time * odd_time_d;
    _st.x -= step(1.0, mod(-_st.y,2.0)) * odd_time * odd_time_d;
    return fract(_st);
}

float circle(in vec2 _st, in float _radius){
  vec2 dist = _st-vec2(0.500,0.500);
	return 1.-smoothstep(
    _radius+(_radius*0.01),
    _radius-(_radius*0.01),
    dot(dist,dist)*4.000);
}


void mainImage(out vec4 fragColor, in vec2 fragCoord ) {
  vec2 uv = fragCoord.xy/iResolution.xy;
  proportion(uv);
  vec3 color = vec3(1.,1.,1.);
  uv = tile(uv, 8.);
  
  color *= circle(uv, .6);

  fragColor = vec4(color,1.);
}