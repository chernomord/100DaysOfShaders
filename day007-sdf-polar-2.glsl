#ifdef GL_ES
precision mediump float;
#endif


void proportion(inout vec2 st) {
  st.x *= iResolution.x/iResolution.y;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ){
    vec2 st = fragCoord.xy/iResolution.xy;
    proportion(st);
    vec3 color = vec3(0.0);

    // разница между текущей точкой и центром оси координат
    vec2 pos = vec2(0.5)-st; 

    float r = length(pos)*2.0;
    float a = atan(pos.y,pos.x) + iTime;

    float f = cos(a*3.);
    f = abs(cos(a*3.));
    // f = abs(cos(a*2.5))*.5+.3;
    // f = abs(cos(a*12.)*sin(a*3.))*.8+.1;
    // f = smoothstep(-.5,1., cos(a*10.))*0.2+0.5;

    color = vec3( (1.- smoothstep(f,f+0.01,r)) );

    fragColor = vec4(color, 1.0);
}