extends Node2D

@onready var start_platform: StartPlatform = $StartPlatform
@onready var player: Player = $Player


func _ready() -> void:
	player.global_position = start_platform.get_spawn_pos()

	var traps: Array[Node] = get_tree().get_nodes_in_group("trap")

	for trap: Trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body: Node2D) -> void:
	if body is Player:
		reset_player()


func _on_trap_touched_player() -> void:
	reset_player()


func reset_player() -> void:
	player.velocity = Vector2.ZERO
	player.global_position = start_platform.get_spawn_pos()
