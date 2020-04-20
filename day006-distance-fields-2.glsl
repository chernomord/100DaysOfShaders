#ifdef GL_ES
precision mediump float;
#endif

vec3 colorA = vec3(0.549,0.141,0.412);
vec3 colorB = vec3(1.000,0.833,0.224);

vec4 cDay = vec4(0.200,0.166,0.324,1.);
vec4 cNight = vec4(0.440,0.855,1.000,1.);

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
	return 1.-smoothstep(_radius,
                         _radius + _radius*0.05,
                         dot(dist,dist)*4.0);
}
void mainImage(out vec4 fragColor, in vec2 fragCoord ){
    vec2 st = fragCoord.xy/iResolution.xy;
    float stT = fract(iTime);
    vec2 center = vec2(.5,.5);

    float rad = 1.2 * .08/center.y;

    vec4 background = vec4(0.,0.,0.,1.);

    float pct = abs(sin(iTime*4.));

    float colorBeat = (center.y - .15)*2.;

    background = mix(cDay, cNight, colorBeat);

    vec4 color = vec4(mix(colorA, colorB, colorBeat), 1.);

    vec4 circle1 = vec4(color.rgb, circle(st, .1));

    vec4 ball = circle1;

    color = vec4(
            mix(
            background,
            ball,
            ball.a)
    );

    fragColor = color;
}