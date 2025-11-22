extends Control

@onready var player: AudioStreamPlayer = $AudioStreamPlayer

var stream: AudioStreamFFmpeg


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_window().files_dropped.connect(_on_audio_drop):
		printerr("Couldn't connect files_dropped!")
	
	print("loading audio ...")
	stream = AudioStreamFFmpeg.new()
	if stream.open("https://daserste-live.ard-mcdn.de/daserste/live/hls/de/masteraudio1.m3u8", -1) == 0:
		player.stream = stream
	
	print("Audio loaded")
	player.connect("finished", _stream_ended)
	player.play()

func _stream_ended():
	print("Audio ended")
	
func _on_audio_drop(a_files: PackedStringArray) -> void:
	print("loading audio ...")
	stream = AudioStreamFFmpeg.new()
	if stream.open(a_files[0]) == 0:
		player.stream = stream

	print("Audio loaded")
	player.play()
