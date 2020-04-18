#ifdef GL_ES
precision mediump float;
#endif

#define PI=3.14

float dfCircle(in vec2 st, in vec2 center, float r) {
    float pct = 0.;
    pct = distance(st, center) * 2.;
    pct = smoothstep(r,r-.01,pct);
    return pct;
}

float beat2(in float stT) {
    return sqrt(stT*(2.-2.*stT));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ){
    vec2 st = fragCoord.xy/iResolution.xy;
    float stT = fract(iTime);
    vec3 color = vec3(1.0, .3,.3);

    float rad = .3;

    vec2 center = vec2(.5, beat2(stT)/2. +.2);

    color *=rad*2.;

    color *= vec3(dfCircle(st, center, rad));

    fragColor = vec4(color,1.0);
}