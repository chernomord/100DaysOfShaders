#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

float box(in vec2 _st, in vec2 _size){
    _size = vec2(0.5) - _size*0.5;
    vec2 uv = smoothstep(_size,
                        _size+vec2(0.001),
                        _st);
    uv *= smoothstep(_size,
                    _size+vec2(0.001),
                    vec2(1.0)-_st);
    return uv.x*uv.y;
}

float cross(in vec2 _st, float _size){
    return  box(_st, vec2(_size,_size/4.)) +
            box(_st, vec2(_size/4.,_size));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ){
  vec2 st = fragCoord.xy/iResolution.xy;
  vec3 color = vec3(0.0);

    // To move the cross we move the space
    float x = -1.*(sin(iTime*PI));
    // float y = -.5*(sin(u_time*PI)-1.);
    float y = cos(iTime*TWO_PI)*.5;
    vec2 translate = vec2(x,y);
    // translate.x = pow(translate.x,u_time);
    st += translate*0.35;

    // Show the coordinates of the space on the background
    color = vec3(st.x,st.y,0.0);

    // Add the shape on the foreground
    color += vec3(cross(st,0.25));

  fragColor = vec4(color, 1.0);
}