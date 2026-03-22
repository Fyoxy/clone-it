extends AudioStreamPlayer

@export var songs: Array[AudioStreamOggVorbis] = []
@export var timer: Timer

func _on_timer_timeout():
	# Wait between 25 to 120 seconds to play next song
	var wait_time = (randi_range(1, 5)) * 20 + (randi_range(1, 4)) * 5
	stream = songs.pick_random()
	play()
	timer.start(wait_time)
