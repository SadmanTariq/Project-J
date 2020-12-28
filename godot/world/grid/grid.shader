shader_type spatial;
render_mode unshaded;

uniform float divisions = 50.0;

void fragment(){
	float v = max(smoothstep(0.98, 0.99, max(fract(UV.x * divisions),
										     1. - fract(UV.x * divisions))),
				  smoothstep(0.98, 0.99, max(fract(UV.y * divisions),
										     1. - fract(UV.y * divisions))));
	ALBEDO = vec3(v);
	ALPHA = v;
}