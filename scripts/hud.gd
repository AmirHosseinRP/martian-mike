class_name HUD

extends Control

@onready var time_label: Label = $TimeLabel


func set_time_label(value: int) -> void:
	time_label.text = "Time:" + str(value)
