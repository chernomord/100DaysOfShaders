
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

void mainImage(out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord.xy/iResolution.xy;
    // uv = fract((uv)*3.);
    remap(uv);
    proportion(uv);

    uv *= rotate2d(sin(iTime*2.));
    uv *= scale(vec2((sin(iTime)+3.5)/3.));

    vec2 pos = vec2(0.0);

    vec2 uv_r = uv * scale(vec2(.5,(sin(iTime)+2.)*3.));
    vec2 uv_b = uv + vec2(cos(iTime*4.)*2.,.0) /4.;
    
    vec2 p_ar = polar(pos, uv);
    
    vec2 p_ar_r = polar(pos, uv_r);
    vec2 p_ar_b = polar(pos, uv_b);
    float f = cos(p_ar[1]*8.0)/6. +.5;
    float f_r = cos(p_ar_r[0]*8.0)/6. +.5;
    float f_b = cos(p_ar_b[0]*8.0)/6. +.5;
    vec3 color = vec3( 
        smoothstep(f,f+0.2,p_ar_r[1]),
        smoothstep(f,f+0.024,p_ar[1]+(sin(iTime*5.)+2.)/4.),
        smoothstep(f,f+0.1,p_ar_b[1]) 
        );

    fragColor = vec4(color,1.);
}