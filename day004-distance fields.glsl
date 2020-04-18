#ifdef GL_ES
precision mediump float;
#endif

vec3 colorA = vec3(0.549,0.141,0.412);
vec3 colorB = vec3(1.000,0.833,0.224);

vec4 cDay = vec4(0.200,0.166,0.324,1.);
vec4 cNight = vec4(0.440,0.855,1.000,1.);

float dfCircle(in vec2 st, in vec2 center, float r, float blur) {
    float pct = 0.;
    pct = distance(st, center) * 2.;
    pct = smoothstep(r,r-blur,pct);
    return pct;
}

vec2 pCenter(in float shift) {
    float stT = fract(iTime/2.);
    float beat = sqrt((stT+shift) * (2. - 2. * (stT+shift)));
    return vec2(.5, beat/2. +.3);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ){
    vec2 st = fragCoord.xy/iResolution.xy;
    float stT = fract(iTime);
    vec2 center = pCenter(0.);

    float rad = 1.2 * .08/pCenter(0.).y;

    vec4 background = vec4(0.,0.,0.,1.);

    float pct = abs(sin(iTime*4.));

    float colorBeat = (pCenter(0.).y - .15)*2.;

    background = mix(cDay, cNight, colorBeat);

    vec4 color = vec4(mix(colorA, colorB, colorBeat), 1.);

    vec4 circle1 = vec4(color.rgb, dfCircle(st, pCenter(0.), rad, .01));
    vec4 circle2 = vec4(color.rgb, dfCircle(st, pCenter(-0.015), rad, .01));
    vec4 circle3 = vec4(color.rgb, dfCircle(st, pCenter(-0.03), rad, .01));

    vec4 halo = vec4(color.rgb, dfCircle(st, pCenter(0.), rad*3.0, 1.2));

    vec4 ball = vec4(
        mix(
            mix(
            circle1,
            circle2,
            circle2.a/2.),
            circle3,
            circle3.a/3.
    ));

    ball = mix(halo, ball, ball.a);

    color = vec4(
            mix(
            background,
            ball,
            ball.a)
    );

    fragColor = color;
}