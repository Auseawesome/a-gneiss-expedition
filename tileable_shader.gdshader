shader_type canvas_item;

uniform sampler2D stone_tex: repeat_enable, filter_nearest;
uniform sampler2D dirt_tex: repeat_enable, filter_nearest;
uniform float stone_size = 32;
uniform float dirt_size = 64;
varying vec2 world_position;

void vertex(){
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	bool stone_apply = bool(floor(COLOR.r) * floor(COLOR.a));
	bool dirt_apply = bool(floor(COLOR.g) * floor(COLOR.a));
	vec4 stone_color = texture(stone_tex, world_position / stone_size);
	vec4 dirt_color = texture(dirt_tex, world_position / dirt_size);
	
	// combine original color and overlay color together
	COLOR = stone_apply ? stone_color : (dirt_apply ? dirt_color : COLOR);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
