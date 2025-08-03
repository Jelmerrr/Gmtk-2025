extends Area2D

@onready var ray = $RayCast2D
@onready var screen_size = Vector2i(640,360)
@onready var sprite_2d: Sprite2D = $Sprite2D


var tile_size = 16
var key_inputs: Array
var inputs = {
				"ui_right": Vector2.RIGHT,
				"ui_left": Vector2.LEFT,
				"ui_up": Vector2.UP,
				"ui_down": Vector2.DOWN
			}
var animation_speed = 6
var moving = false


var currentState: Utils.playerSurfaceState
var startOfMovementState: Utils.playerSurfaceState

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	SignalBus.Update_Player_State.connect(Change_Player_State)

func _physics_process(_delta: float) -> void:
	if !moving:
		var direction = Vector2.ZERO if key_inputs.is_empty() else inputs[key_inputs[0]]
		#Pak alleen 1e input, dit prevent sideways movement zonder een axis priority te geven
		if direction != Vector2(0.0, 0.0): #Move alleen maar wanneer er input is
			move(direction)

func _unhandled_input(event: InputEvent) -> void:
	#Store alle movement inputs in een array
	if event is InputEventKey:
		for dir in inputs.keys():
			if event.is_action_pressed(dir):
				if key_inputs.find(dir) == -1:
					key_inputs.push_front(dir)
			elif event.is_action_released(dir):
				key_inputs.erase(dir)

#func _unhandled_input(event):
#	if moving:
#		return
#	for dir in inputs.keys():
#		if event.is_action_pressed(dir):
#			move(dir)

func move(dir):
	sprite_2d.look_at(sprite_2d.global_position + dir)
	ray.target_position = dir * tile_size
	ray.force_raycast_update()
	startOfMovementState = currentState
	match currentState:
		Utils.playerSurfaceState.Walking:
			Walk(dir)
		Utils.playerSurfaceState.Sliding:
			Slide(dir)

func Walk(dir):
	if !ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + dir * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
		screen_wrap()
		if startOfMovementState != currentState:
			#Player gaat van snow -> ice
			Slide(dir)

func Slide(dir):
	while !ray.is_colliding() && currentState == Utils.playerSurfaceState.Sliding:
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + dir * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
		screen_wrap()
		#Ik heb geprobeerd de code na die if/while statement in een aparte method te gooien,
		#dit crasht godot wanneer de while triggered lol, beetje ugly code maar probleem voor later.

func screen_wrap():
	##left to right wrap
	if position.x < -screen_size.x/2:
		position.x = screen_size.x/2
		position = position.snapped(Vector2(-1, 0) * tile_size)
		position += Vector2(-1, 0) * tile_size/2
		SignalBus.Force_State_Update.emit()

	##right to left wrap
	if position.x > screen_size.x/2:
		position.x = -screen_size.x/2
		position = position.snapped(Vector2(1, 0) * tile_size)
		position += Vector2(1, 0) * tile_size/2
		SignalBus.Force_State_Update.emit()

	##top to bottom wrap
	if position.y > screen_size.y/2:
		position.y = -screen_size.y/2
		position = position.snapped(Vector2(0, 1) * tile_size)
		position += Vector2(0, 1) * tile_size/2
		SignalBus.Force_State_Update.emit()
		
	##bottom to top wrap
	if position.y < -screen_size.y/2:
		position.y = screen_size.y/2
		position = position.snapped(Vector2(0, -1) * tile_size)
		position += Vector2(0, -1) * tile_size/2
		SignalBus.Force_State_Update.emit()

func Change_Player_State(state: Utils.playerSurfaceState):
	currentState = state
