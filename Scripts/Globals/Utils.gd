extends Node

enum playerSurfaceState{
	Walking,
	Sliding,
}

func _process(_delta: float) -> void:
	if Input.is_action_pressed("DebugExit"): #Placeholder voor debugging, haal dit weg voor build.
		pass
		#get_tree().quit()
