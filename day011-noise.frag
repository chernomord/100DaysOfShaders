#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14*4.

float rand(float x) {
    return fract(sin(x)*10000.);
}

float noise(float inp) {
    float i = floor(inp);
    float f = fract(inp);
    return mix(rand(i), rand(i+1.), smoothstep(0.,1.0,f));
}

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st - vec2(0.5,.5);
    float sdf = dot(dist,dist)*4.000;
    float angle = atan(dist.y,dist.x);
    float rnd = noise(angle*PI);

    _radius += rnd/6.;
	return 1.-smoothstep(_radius-_radius*0.21,
                        _radius-_radius*0.22,
                        sdf);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ) {
	vec2 st = fragCoord.xy/iResolution.xy;
    st.x *= iResolution.x/iResolution.y;

	vec3 color = vec3(
        circle(st + vec2(.03,.0),0.988),
        circle(st,0.988),
        circle(st-vec2(.03,.05),0.988));

    color = vec3(circle(st,1.));

	fragColor = vec4( color, 1.0 );
}