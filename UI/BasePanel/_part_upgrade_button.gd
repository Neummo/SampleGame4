extends TextureButton
class_name PartUpgradeButtonInterface

@onready var panel: Panel = $Panel
@onready var line: Line2D = $Line2D
var part_display: Control
var description: String
var player: CharacterBody2D
var description_panel: RichTextLabel
var unlockable: bool = true
var unlocked: bool = false

func _ready() -> void:
	part_display = get_tree().get_first_node_in_group("PartDisplay")
	player = get_tree().get_first_node_in_group("Player")
	description_panel = get_tree().get_first_node_in_group("Description")
	if get_parent() is PartUpgradeButton:
		unlockable = false
	set_disabled(true)

func _process(_delta: float) -> void:
	if get_parent() is PartUpgradeButton:
		line.clear_points()
		line.add_point(global_position + size / 2)
		line.add_point(get_parent().global_position + size / 2)

func on_select() -> void:
	Values.parts -= 1
	set_disabled(true)
	unlocked = true
	panel.show_behind_parent = true
	
	for child in get_children():
		if child is PartUpgradeButton:
			child.line.default_color = Color(1, 1, 1)
			child.unlockable = true
			
	part_display.check_prices()

func check_price() -> void:
	if Values.parts > 0 and unlockable and not unlocked:
		set_disabled(false)
	else:
		set_disabled(true)

func hover() -> void:
	description_panel.set_text(description.replace("-nl", "\n"))

func unhover() -> void:
	description_panel.set_text("")
