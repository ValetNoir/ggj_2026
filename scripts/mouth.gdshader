shader_type canvas_item;

uniform vec4 mask_color;

void vertex() { }

void fragment() {
	if(COLOR.r == COLOR.g && COLOR.g == COLOR.b) {
		float mix_amount = COLOR.r;
		COLOR = mix(COLOR, mask_color, mix_amount * 0.5);
	}
}