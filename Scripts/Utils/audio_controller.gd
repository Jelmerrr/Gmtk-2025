extends Node2D

@onready var sfx_channels: Node2D = $"SFX Channels"

var Channels: Array[AudioStreamPlayer2D]

func _ready() -> void:
	SignalBus.Play_SFX.connect(Play_SFX)
	SignalBus.Stop_SFX.connect(Stop_SFX)
	
	for channel in sfx_channels.get_children():
		Channels.append(channel)

func Play_SFX(SFX, starting_time):
	var availablePlayer = GetAvailablePlayer()
	availablePlayer.stream = SFX
	availablePlayer.play(starting_time)

func Stop_SFX(SFX):
	var currentlyPlaying = GetPlayingPlayer(SFX)
	if currentlyPlaying != null:
		currentlyPlaying.stop()

func GetAvailablePlayer():
	for item in Channels:
		if item.playing == false:
			return item

func GetPlayingPlayer(SFX):
	for item in Channels:
		if item.playing == true && item.stream == SFX:
			return item
