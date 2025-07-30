extends CharacterBody2D

@export var speed = 300.0

@onready var screen_size = DisplayServer.window_get_size()##get_viewport_rect().size

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed
	move_and_slide()
	
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
