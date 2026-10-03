extends Node2D

class_name Trap

signal touched_player


func _on_area_2d_body_entered(_body: Node2D) -> void:
	touched_player.emit()
