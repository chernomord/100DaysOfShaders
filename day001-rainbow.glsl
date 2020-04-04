#ifdef GL_ES
precision mediump float;
#endif

float PI = 3.14;

vec3 red = vec3(1.0,0.0,0.0);
vec3 green = vec3(0.0,1,0);
vec3 blue = vec3(0.0,0.0,1);

vec3 white = vec3(1.,1.,1.);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;

    float redPct =  (uv.y > .3) ? sin( (uv.y - 0.7) / 0.23 ) * 0.5 + 0.5 : 0. ;
    
    float greenPct = sin( (uv.y - 0.25) / 0.15 ) * 0.5 + 0.5;

    float bluePct =  (uv.y < .7) ? sin( (uv.y +.3) / 0.21 ) * 0.5 + 0.5 : 0. ;

    // float bluePct = sin( (uv.y - 0.5) / 0.314 ) * -0.5 + 0.5 ;
    
    vec3 color = vec3(redPct,greenPct,bluePct);

    fragColor = vec4(color,1.0);
}