precision highp float;

uniform vec2 uMouse;
uniform float uTime;
uniform sampler2D tAudioData;

uniform vec3 uDepthColor;
uniform vec3 uSurfaceColor;
uniform float uColorOffset;
uniform float uColorMultiplier;

uniform float uLightIntensity;
uniform float uAmbientLightIntensity;

// uniform vec3 uDepthColor;
// uniform vec3 uSurfaceColor;
// uniform float uColorOffset;
// uniform float uColorMultiplier;

//these values are being passed by the vertex shader
varying vec3 myNormal;
varying float vDisplacement;


void main() {
    // light from the top
    vec3 light = vec3(0.,3.0,0.0);
    
    // Get the normal of the light
    // Remember the Unit Vector of the light is the direction of the light 
    vec3 invert = vec3(1.,1.,1.);
    invert=myNormal * invert;
    
    light = normalize(light);
    
    // return the maximum of either 0, or the squared distance 
    float prod = max(0., dot(myNormal,light));
    // float prod = 1.0;

    vec3 surfaceColor = uSurfaceColor;
    surfaceColor.x += (sin(uTime)+1.0)/5.0;
    surfaceColor.y += (cos(uTime)+1.0)/5.0;

    float colorStrengthVariation = uColorOffset;
    float mixStrength = vDisplacement * colorStrengthVariation + (1.0 - colorStrengthVariation);
    // mixStrength = (mixStrength + uColorOffset) * uColorMultiplier;
    vec3 color = mix(uDepthColor, surfaceColor, mixStrength);

    // use the dot product of the normal and the light
    // To calculate the shading for the sphere
    // gl_FragColor = vec4(color, 1.0);
    gl_FragColor = vec4(prod, prod, prod, 1.0) * vec4(color, 1.0) + vec4(vec3(0.4),1.) * vec4(color, 1.0);
    // float f = texture2D( tAudioData, vec2(0.8, 0.0 ) ).r;
    // gl_FragColor = vec4(vec3(f), 1.0);
    
}