extends Area2D

@onready var ray = $RayCast2D
@onready var screen_size = DisplayServer.window_get_size()


var tile_size = 64
var inputs = {
				"ui_right": Vector2.RIGHT,
				"ui_left": Vector2.LEFT,
				"ui_up": Vector2.UP,
				"ui_down": Vector2.DOWN
			}
var animation_speed = 6
var moving = false


func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	while !ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
		screen_wrap()

func screen_wrap():
	##left to right wrap
	if position.x < -screen_size.x/2:
		position.x = screen_size.x/2
		
	##right to left wrap
	if position.x > screen_size.x/2:
		position.x = -screen_size.x/2
	
	##top to bottom wrap
	if position.y > screen_size.y/2:
		position.y = -screen_size.y/2
		
	##bottom to top wrap
	if position.y < -screen_size.y/2:
		position.y = screen_size.y/2
