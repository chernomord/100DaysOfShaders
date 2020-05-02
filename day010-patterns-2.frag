
void remap(inout vec2 st) {
  st = st/.5 - 1.;
}

void proportion(inout vec2 st) {
  st.x *= iResolution.x/iResolution.y;
}


vec2 polar(in vec2 pos, in vec2 uv) {
    vec2 dist = pos - uv;
    return vec2(atan(dist.y,dist.x)+iTime/4., dot(dist,dist)*4.);
}

mat2 scale(vec2 _scale){
    return mat2(_scale.x,0.0,
                0.0,_scale.y);
}

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

vec2 tile (vec2 _st, float _zoom) {
    _st *= _zoom;
    return fract(_st);
}

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.500,0.500);
	return 1.-smoothstep(_radius+(_radius*0.01),
                         _radius-(_radius*0.01),
                         dot(dist,dist)*4.000);
}


void mainImage(out vec4 fragColor, in vec2 fragCoord ) {
  vec2 uv = fragCoord.xy/iResolution.xy;
  vec3 color = vec3(1.,1.,1.);
  uv = tile(uv, 3.);
  
  color *= circle(uv, .6);

  fragColor = vec4(color,1.);
}