shader_type canvas_item;

uniform sampler2D overlay_tex: repeat_enable, filter_linear;
uniform float scale = 0.006;
uniform vec4 color;
varying vec2 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	float mix_amount = COLOR.r;
	vec4 overlay_color = texture(overlay_tex, world_position * scale);
	vec4 grey_scale = mix(COLOR, overlay_color, mix_amount);
	COLOR = mix(grey_scale, color, mix_amount * 0.5);
}
