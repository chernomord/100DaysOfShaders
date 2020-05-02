#ifdef GL_ES
precision mediump float;
#endif

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.500,0.500);
	return 1.-smoothstep(_radius-(_radius*0.11),
                         _radius+(_radius*-0.966),
                         dot(dist,dist)*4.000);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ) {
	vec2 st = fragCoord.xy/iResolution.xy;

	vec3 color = vec3(
        circle(st + vec2(.03,.0),0.988),
        circle(st,0.988),
        circle(st-vec2(.03,.05),0.988));

	fragColor = vec4( color, 1.0 );
}