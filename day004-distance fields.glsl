#ifdef GL_ES
precision mediump float;
#endif

#define TWO_PI 6.28318530718


float dfCircle(in vec2 st, in vec2 center, float r) {
    float pct = 0.;
    pct = distance(st, center) * 2.;
    pct = smoothstep(r,r-.01,pct);
    return pct;
}

vec2 pCenter(in float shift) {
    float stT = fract(iTime);
    float beat = sqrt((stT+shift) * (2. - 2. * (stT+shift)));
    return vec2(.5, beat/2. +.2);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ){
    vec2 st = fragCoord.xy/iResolution.xy;
    float stT = fract(iTime);
    vec2 center = pCenter(0.);
    vec3 pColor = vec3(0.0);

    float rad = .3;

    vec4 black = vec4(0.,0.,0.,1.);

    vec4 color = vec4(1.,.2,.2, 1.);

    vec4 circle1 = vec4(color.rgb, dfCircle(st, pCenter(0.), rad));
    vec4 circle2 = vec4(color.rgb, dfCircle(st, pCenter(-0.015), rad));
    vec4 circle3 = vec4(color.rgb, dfCircle(st, pCenter(-0.03), rad));

    color = vec4(
        mix(
            mix(
            mix(
            black,
            circle1,
            circle1.a),
            circle2,
            circle2.a/2.),
            circle3,
            circle3.a/3.)
    );

    fragColor = color;
}