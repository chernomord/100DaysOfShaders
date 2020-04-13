#ifdef GL_ES
precision mediump float;
#endif


float rect(in vec2 st, in vec4 offsets) {
    float outL = .01;

    vec2 bl = smoothstep(offsets.xy, offsets.xy + .005, st);
    float pct = bl.x*bl.y;
    vec2 tr = smoothstep(offsets.zw, offsets.zw +.005, 1.-st);
    pct *= tr.x * tr.y;

    float pctInner;
    bl = smoothstep(offsets.xy+outL, offsets.xy+outL+.005, st);
    pctInner = bl.x*bl.y;
    tr = smoothstep(offsets.zw+outL, offsets.zw+outL+.005, 1.-st);
    pctInner *= tr.x * tr.y;
    pctInner = pctInner*-1.+1.;

    return pctInner * pct;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ){
    vec2 st = fragCoord.xy/iResolution.xy;
    vec3 color = vec3(0.0);

    color = vec3(
        rect(st, vec4(.1,.2,.1,.1)) + 
        rect(st, vec4(.4,.1,.3,.6))
        );

    fragColor = vec4(color,1.0);
}