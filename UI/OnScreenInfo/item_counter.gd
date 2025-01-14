extends TextureRect

@onready var count_label: Label = $Label
var count: int = 0
var id: int

func _ready() -> void:
	increment()

func increment() -> void:
	count += 1
	count_label.set_text(str(count))
