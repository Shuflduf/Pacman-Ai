shader_type canvas_item;

uniform vec4 colour: source_color;

void fragment() {
	COLOR = colour;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
