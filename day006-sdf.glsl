#ifdef GL_ES
precision mediump float;
#endif


void mainImage(out vec4 fragColor, in vec2 fragCoord ){
  vec2 st = fragCoord.xy/iResolution.xy;
  st.x *= iResolution.x/iResolution.y;
  //vec3 color = vec3(0.0);
  float d = 0.0;

  // Remap the space to -1. to 1.
  st = st *2.-1.;

  // Make the distance field
  d = length( abs(st)-.3 );
  //d = length( min(abs(st)-.3,0.) );
  //d = length( max(abs(st)-.3,0.) );

  // Visualize the distance field
  vec4 color = vec4(vec3(fract(d*10.0)),1.0);

  // Drawing with the distance field
  color = vec4(vec3( step(.3,d) ),1.0);
  color = vec4(vec3( step(.3,d) * step(d,.4)),1.0);
  color = vec4(vec3( smoothstep(.3,.4,d)* smoothstep(.6,.5,d)) ,1.0);
    fragColor = color;
}