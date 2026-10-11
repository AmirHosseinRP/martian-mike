extends Node

enum SFX { HURT, JUMP }

var hurt_sound: Resource = preload("res://assets/audio/hurt.wav")
var jump_sound: Resource = preload("res://assets/audio/jump.wav")


func play_sfx(sfx_name: SFX) -> void:
	var stream: Resource = null

	if sfx_name == SFX.HURT:
		stream = hurt_sound
	elif sfx_name == SFX.JUMP:
		stream = jump_sound
	else:
		return

	var asp: AudioStreamPlayer = AudioStreamPlayer.new()
	asp.name = "SFX"
	asp.stream = stream
	asp.volume_db = -3

	add_child(asp)

	asp.play()

	await asp.finished

	asp.queue_free()
