shader_type canvas_item;
varying flat int instance_id;

void vertex() {
	instance_id = INSTANCE_ID;
}

void fragment() {
	COLOR = texture(TEXTURE, UV + vec2(smoothstep(0.05, 1.5, (1. - UV.y)) * sin(TIME + float(instance_id)) * 0.2, 0.0) );
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
