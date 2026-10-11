class_name UILayer

extends CanvasLayer

@onready var win_screen: WinScreen = $WinScreen


func show_win_screen(flag: bool) -> void:
	win_screen.visible = flag
