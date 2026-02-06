shader_type canvas_item;

instance uniform vec4 mask_color;

void vertex() { }

void fragment() {
	if(COLOR.r == COLOR.g && COLOR.g == COLOR.b) {
		float mix_amount = COLOR.r;
		COLOR *= mask_color;
	}
}