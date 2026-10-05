extends Parallax2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var texture: Texture2D = preload("res://assets/textures/bg/Blue.png")
@export var scroll_speed: int = 20


func _ready() -> void:
	sprite_2d.texture = texture


func _process(delta: float) -> void:
	sprite_2d.region_rect.position += Vector2(scroll_speed * delta, scroll_speed * delta)

	if sprite_2d.region_rect.position >= Vector2(64, 64):
		sprite_2d.region_rect.position = Vector2.ZERO
