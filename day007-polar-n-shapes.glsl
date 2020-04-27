#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

void proportion(inout vec2 st) {
  st.x *= iResolution.x/iResolution.y;
}

float nShape(in vec2 st, in int N, in vec2 c) {
  float d = 0.0;
  vec2 lSt = (st *2.-1.0) + -1.*c;
  float a = atan(lSt.x,lSt.y)+PI;
  float r = TWO_PI/float(N);
  d = cos(floor(.5+a/r)*r-a)*length(lSt);
  return 1.0-smoothstep(.4,.41,d);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ){
  vec2 st = fragCoord.xy/iResolution.xy;
  proportion(st);
  vec3 color = vec3(0.0);

  float shape1 = nShape(st, 9, vec2(0., 0.));
  float shape2 = nShape(st, 4, vec2(0., 0.));

  color = vec3(shape1);

  fragColor = vec4(color, 1.0);
}