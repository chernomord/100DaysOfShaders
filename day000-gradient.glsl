#ifdef GL_ES
precision mediump float;
#endif

float rand( vec2 co ){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453) * 0.5 - 0.25;
}

void noise( inout vec3 color, vec2 uv, float level ) {
    color.rgb = max(min(color.rgb + vec3(rand(uv) * level), vec3(1)), vec3(0));
}

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    
    vec3 pct = vec3(uv.y);
    
    pct.r = mix(
        smoothstep(0.0,.5, uv.y), 
        smoothstep(.3, .31, uv.y), 
        .5
    );
    pct.b = smoothstep(.1, .6, uv.y);

    vec3 color = mix(colorA, colorB, pct);

    
    noise(color, uv, .15);

    fragColor = vec4(color,1.0);
}