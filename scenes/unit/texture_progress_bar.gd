extends TextureProgressBar

func _draw():
	var bar_height = size.y
	var bar_width = size.x
	#could be dynamic. You maybe want smaller lines if there are a to many
	var line_width = 1
	var line_color = "#3d3957"
	#should also be dynamic. Determines after how much life a line is drawn
	var life_per_line = 1
	#lets say we wnat to draw lines from the top to the middle of the bar
	var line_height = bar_height
	
	var offset = texture_progress_offset.x
	
	#how many lines should be drawn
	var lines_to_draw : int = int(max_value / life_per_line)
	print(bar_width)
	if (lines_to_draw > 0):
		var pixel_per_line = int(bar_width / lines_to_draw)
		var draw_pos_x = offset + pixel_per_line
		for i in lines_to_draw:
			if (draw_pos_x < bar_width):
				draw_line(Vector2(draw_pos_x,0), Vector2(draw_pos_x, line_height), line_color, line_width)
			draw_pos_x = draw_pos_x + pixel_per_line
			
