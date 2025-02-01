extends Control

@onready var start: TextureButton = $VBoxContainer/Start
@onready var armory_panel: TextureRect = $ArmoryPanel
@onready var options_panel: TextureRect = $OptionsPanel

func _ready() -> void:
	get_tree().set_deferred("paused", false)
	start.grab_focus()
	Values.init_player_stats()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://world.tscn"))

func _on_options_pressed() -> void:
	if options_panel.is_visible():
		options_panel.set_visible(false)
	else:
		armory_panel.set_visible(false)
		options_panel.set_visible(true)

func _on_armory_pressed() -> void:
	if armory_panel.is_visible():
		armory_panel.set_visible(false)
	else:
		armory_panel.set_visible(true)
		options_panel.set_visible(false)

func _on_quit_pressed() -> void:
	get_tree().quit()
