extends ProgressBar

@export var timer: Timer
@export var damage_bar: ProgressBar
@export var label: Label

var health: int = 0 : set = _set_health

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	update_hp_label()
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health
	
func init_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health
	update_hp_label()

func update_max_health(_health):
	max_value = _health
	damage_bar.max_value = _health
	value = health
	damage_bar.value = health
	update_hp_label()

func update_hp_label() -> void:
	if owner is World:
		label.set_text(str(snapped(health, 1)) + ' / ' + str(snapped(max_value, 1)))
	
func _on_timer_timeout():
	damage_bar.value = health
