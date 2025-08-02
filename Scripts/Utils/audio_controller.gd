extends Node2D

@onready var sfx_channels: Node2D = $"SFX Channels"
@onready var music_player: AudioStreamPlayer2D = $MusicPlayer
@onready var music_delay: Timer = $MusicDelay

var Channels: Array[AudioStreamPlayer2D]

func _ready() -> void:
	SignalBus.Play_SFX.connect(Play_SFX)
	SignalBus.Stop_SFX.connect(Stop_SFX)
	PlayMusic()
	
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

func GetMusicDelay():
	if music_player.playing == false:
		var delay = RngHandler.rng.randi_range(15, 60)
		music_delay.wait_time = delay
		music_delay.start()

func _on_music_delay_timeout() -> void:
	PlayMusic()
	music_delay.stop()

func PlayMusic():
	#picks a random song
	music_player.stream = AudioLibrary.MusicDict[AudioLibrary.MusicDict.keys()[RngHandler.rng.randi_range(0, AudioLibrary.MusicDict.size() -1 )]]
	music_player.play(0)

func _on_music_player_finished() -> void:
	GetMusicDelay()
