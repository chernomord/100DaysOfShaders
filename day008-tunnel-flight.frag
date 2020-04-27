#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718
#define N 9
vec3 iColor = vec3(0.980,0.714,0.261);

void proportion(inout vec2 st) {
  st.x *= iResolution.x/iResolution.y;
}

void remap(inout vec2 st) {
  st = st/.5 - 1.;
}

// vec3 iColor = vec3(0.980,0.714,0.261);

vec4 nShape(in vec2 st, in vec2 c, in float tShift) {
  float d = 0.0;

  float cTime = (iTime + tShift*TWO_PI); 
  // cTime = PI*2.*0.;
  vec2 translate = vec2(cos(cTime),sin(cTime));

  vec2 lSt = st + c + translate*.25;

  float a = atan(lSt.x,lSt.y)+PI - (iTime+tShift*6.5)*.4;
  float r = TWO_PI/float(N);
  d = cos(floor(.5+a/r)*r-a)*length(lSt);
  float rad = pow(0.01, 1.+fract((iTime/8.+tShift))*-1.5);
  // float alpha = smoothstep(rad,rad+.01,d) * rad *.5;
  float tAlpha = smoothstep(rad,rad+.01,d);
  float alpha = tAlpha * rad *.5;
  

  float cFactor = smoothstep(rad*3.,rad,d) * 1.;
  float color = alpha * cFactor;

  return vec4(color*iColor, tAlpha);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord ) {
  vec2 st = fragCoord.xy/iResolution.xy;
  remap(st);
  proportion(st);
  // vec4 color = vec4(0.5,0.3,.5*sin(iTime*2.),1.);
  vec4 color = vec4(.1,.1,.1,1.);

  vec2 center = vec2(.0, .0); 

  for (int i=0; i<20; ++i) {
    float fract = float(i)/20.;
    vec4 shape = nShape(st, center, fract);
    shape.r*=sin(iTime + fract*20.);
    shape.g*=cos(iTime + fract*15.);
    shape.g*=cos(iTime + fract*10.);
    color += shape;
    // color = mix(color, shape, shape.a);
  }

  fragColor = vec4(color.rgb, 1.0);
}