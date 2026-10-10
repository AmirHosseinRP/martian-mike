extends Node2D

@onready var start_platform: StartPlatform = $StartPlatform
@onready var finish_platform: FinishPlatform = $FinishPlatform
@onready var player: Player = $Player
@onready var deathzone: Area2D = $Deathzone

@export var next_level: PackedScene = null
@export var level_time: int = 5

var timer_node: Timer
var time_remaining: int = level_time
var is_level_won: bool = false


func _ready() -> void:
	player.global_position = start_platform.get_spawn_pos()

	var traps: Array[Node] = get_tree().get_nodes_in_group("trap")

	for trap: Trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)

	finish_platform.body_entered.connect(_on_finish_platform_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)

	timer_node = Timer.new()
	timer_node.name = "LevelTimer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_timer_timeout)
	add_child(timer_node)
	timer_node.start()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func reset_player() -> void:
	player.velocity = Vector2.ZERO
	player.global_position = start_platform.get_spawn_pos()


func _on_deathzone_body_entered(body: Node2D) -> void:
	if body is Player:
		reset_player()


func _on_trap_touched_player() -> void:
	reset_player()


func _on_finish_platform_body_entered(body: Node2D) -> void:
	if body is Player:
		is_level_won = true

		finish_platform.animate()

		player.isActive = false

		await get_tree().create_timer(1.5).timeout

		if next_level != null:
			get_tree().change_scene_to_packed(next_level)


func _on_timer_timeout() -> void:
	if !is_level_won:
		time_remaining -= 1

		if time_remaining < 0:
			time_remaining = level_time
			reset_player()
