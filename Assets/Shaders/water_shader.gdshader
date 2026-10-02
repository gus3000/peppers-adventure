shader_type spatial;

// render_mode unshaded;
// render_mode diffuse_toon, specular_toon;
render_mode specular_toon;

uniform float height_scale = 0.5;
uniform sampler2D noise;
uniform sampler2D normalmap;

// varying vec2 tex_position;

float wave(vec2 position) {
    position += texture(noise, position / 10.).x * 2. - 1.;
    vec2 wv = 1. - abs(sin(position));
    return pow(1. - pow(wv.x * wv.y, 0.65), 4.)-.5;
}

float height(vec2 position, float time) {
    // vec2 offset = 0.01 * cos(position + time);
    // return texture(noise, (position / 10.0) - offset).x;
    //float h = wave(position *.4);
    //return h;
	float d = wave((position + time) * 0.4) * 0.3;
	d+=wave((position - time) * 0.3) * 0.3;
	d+=wave((position + time) * 0.5) * 0.2;
	d+=wave((position - time) * 0.6) * 0.2;
	
	return d;
}

void vertex() {
	
    // tex_position = VERTEX.xz;
    vec2 pos = VERTEX.xz;
    float k = height(pos, TIME);
	
    VERTEX.xyz += NORMAL * k;
    NORMAL = normalize(vec3(k - height(pos + vec2(.1, 0), TIME), .1, k - height(pos + vec2(0, .1), TIME)));
    // VERTEX.z += cos(VERTEX.x) * sin(VERTEX.z);
    // COLOR.rgb = vec3(.1,.3,.5) * texture(noise,tex_position).xyz;
}

void fragment() {
    float fresnel = sqrt(1.0 - dot(NORMAL, VIEW));

    NORMAL_MAP = texture(normalmap, UV.xy).xyz;
    RIM = 0.2;
    METALLIC = .0;
    ROUGHNESS = 0.01;
    ALBEDO = vec3(0.01, 0.03, 0.05) + (0.1 * fresnel);
    // ALBEDO = vec3(0.01, 0.03, 0.05);

}

// void light() {
// 	// Called for every pixel for every light affecting the material.
// 	// Uncomment to replace the default light processing function with this one.
// }
