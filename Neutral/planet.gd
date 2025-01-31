extends Sprite2D

@onready var timer: Timer = $Timer
@onready var range_indicator: Line2D = $RangeIndicator
var pm: Node2D
var progress: int = 0
var complete: bool = false

func _ready() -> void:
	set_physics_process(false)
	texture = ResourceLoader.load("res://Assets/planets/planet" + str(randi_range(1, 4)) + ".png")
	pm = get_tree().get_first_node_in_group("pm")
	range_indicator.radius = 60
	range_indicator.spawn_position = global_position

func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		timer.start()
		range_indicator.draw_range_indicator(progress)
		progress += 1
		if progress > 362:
			complete_progress()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is Player and not complete:
		set_physics_process(true)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.owner is Player and not complete:
		set_physics_process(false)

func complete_progress() -> void:
	complete = true
	set_physics_process(false)
	pm.get_currency(1000)
	await Values.display_number(snappedf(1000, 0.01), "+",  Vector2(position.x, position.y), "#bab065", null, false)
	var modules: int = randi_range(1, 5)
	pm.get_modules(modules)
	await Values.display_number(modules, "Module +",  Vector2(position.x , position.y), "#d9e22f", null, false)
	var parts: int = randi_range(1, 3)
	pm.get_parts(parts)
	await Values.display_number(parts, "Part +",  Vector2(position.x, position.y), "#8ae346", null, false)
