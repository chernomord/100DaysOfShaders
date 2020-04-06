#ifdef GL_ES
precision mediump float;
#endif

vec3 red = vec3(1.0,0.0,0.0);
vec3 yellow = vec3(1.0,1.0,0.0);
vec3 green = vec3(0.1,1,0.1);
vec3 marina = vec3(0.0,1,1);
vec3 blue = vec3(0.0,0.0,1);



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    
    vec3 flag;

    float step1 = .5;
    
    if (uv.y < step1) {
        flag = mix(red,blue, step(uv.y,step1/2.));
    } else {
        flag = mix(blue, yellow, step(uv.y, step1 + step1/2.));
    }

    fragColor = vec4(flag,1.0);
}