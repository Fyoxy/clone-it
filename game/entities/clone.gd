extends Area3D

@export var spawn_sfx: Array[AudioStreamOggVorbis] = []
@export var audio_stream_player_3d: AudioStreamPlayer3D

func _ready():
	if spawn_sfx.size() > 0:
		audio_stream_player_3d.stream = spawn_sfx.pick_random()
		audio_stream_player_3d.play()
