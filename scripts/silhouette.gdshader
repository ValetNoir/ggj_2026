shader_type canvas_item;

uniform sampler2D overlay_tex: repeat_enable, filter_linear;
uniform bool is_outline_on = false;
uniform vec4 mask_color;

void vertex() {}

void fragment() {
	float mix_amount = COLOR.r;
	vec4 overlay_color = texture(overlay_tex, UV.xy);
	COLOR = mix(COLOR, overlay_color, mix_amount);
	COLOR *= mask_color;
	if(is_outline_on)
		COLOR = mix(COLOR, vec4(1.0), 0.5 * mix_amount);
}