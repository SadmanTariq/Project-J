shader_type spatial;
render_mode unshaded;
//render_mode blend_mix,depth_draw_opaque,cull_disabled,diffuse_burley,specular_schlick_ggx;
uniform sampler2D ocean_noise;
uniform vec4 ocean_color: hint_color;
uniform float land_amount;

uniform sampler2D ground_noise;
uniform float ground_bias;
uniform vec4 ground_color1: hint_color;
uniform vec4 ground_color2: hint_color;


void fragment() {
	float ocean = texture(ocean_noise, UV).r;
	ocean = smoothstep(land_amount, land_amount + 0.01, ocean);
	
	float ground = smoothstep(ground_bias, ground_bias + 0.2,
							  texture(ground_noise, UV).r);
	vec4 ground_color = mix(ground_color1,
							ground_color2,
							ground);

	ALBEDO = mix(ground_color.rgb, ocean_color.rgb, ocean);
	ROUGHNESS = (1.0 - ocean) / 0.7;
	SPECULAR = ocean;
//	EMISSION = (emission.rgb+emission_tex)*emission_energy;
//	ALBEDO = texture(ground_noise, UV).rgb;
}
