extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var gravity: int = 350
@export var speed: int = 100
@export var jump_force: int = 200

var isActive: bool = true


func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta

		if velocity.y >= 500:
			velocity.y = 500

	var direction: float = 0

	if isActive:
		if Input.is_action_just_pressed("jump") && is_on_floor():
			jump(jump_force)

		direction = Input.get_axis("move_left", "move_right")

	if direction != 0:
		animated_sprite_2d.flip_h = direction == -1

	velocity.x = direction * speed

	move_and_slide()

	update_animations(direction)


func update_animations(direction: float) -> void:
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		if velocity.y < 0:
			animated_sprite_2d.play("jump")
		else:
			animated_sprite_2d.play("fall")


func jump(force: int) -> void:
	velocity.y = -force
