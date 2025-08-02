extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func FadeIn():
	animation_player.play("fade_in")

func FadeOut():
	animation_player.play("fade_out")
