#ifdef GL_ES
precision mediump float;
#endif

vec3 red = vec3(1.0,0.0,0.0);
vec3 yellow = vec3(1.0,1.0,0.0);
vec3 green = vec3(0.1,1,0.1);
vec3 marina = vec3(0.0,1,1);
vec3 blue = vec3(0.0,0.0,1);


vec3 gradient(float x, float step1, float step2, float step3) {
    vec3 result;

    if (x < step1) {
    result = mix(red, yellow, x/step1);
    } else if (x <step2) {
        result = mix(yellow, green, (x - step1) / (step2-step1));
    } else if (x < step3) {
        result = mix(green, marina, (x - step2) / (step3-step2));
    } else if (x <= 1.) {
        result = mix(marina, blue, (x - step3) / (1. - step3));
    }

    return result;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    
    vec3 gradient = gradient(uv.x,.28,.5,.75);

    fragColor = vec4(gradient,1.0);
}