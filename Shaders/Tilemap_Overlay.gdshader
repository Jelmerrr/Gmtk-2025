shader_type canvas_item;

uniform sampler2D overlay_tex_red: repeat_enable, filter_nearest;
uniform sampler2D overlay_tex_blue: repeat_enable, filter_nearest;
uniform float scale = 0.0078125; // calculated by 1/texture size e.g. 1/144
varying vec2 world_position;

void vertex(){
	// calculate the world position for use in the fragment shader
    world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	float mix_amount = floor(COLOR.r);
	vec4 overlay_color_1 = texture(overlay_tex_red, world_position * scale);
	COLOR = mix(COLOR, overlay_color_1, mix_amount);

	mix_amount = floor(COLOR.b);
	vec4 overlay_color_2 = texture(overlay_tex_blue, world_position * scale);
	COLOR = mix(COLOR, overlay_color_2, mix_amount);
}