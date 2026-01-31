shader_type canvas_item;

uniform sampler2D overlay_tex: repeat_enable, filter_linear;
uniform vec4 color;

void vertex() {}

void fragment() {
	float mix_amount = COLOR.r;
	vec4 overlay_color = texture(overlay_tex, UV.xy);
	vec4 grey_scale = mix(COLOR, overlay_color, mix_amount);
	COLOR = mix(grey_scale, color, mix_amount * 0.5);
}
