extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent
@export var possesor: String
var timer: Timer

func _ready() -> void:
	if possesor == "Player":
		timer = $Timer

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)
		if possesor == "Player" and Values.push_str > 1:
			owner.max_speed /= Values.push_str
			timer.start()
			

func _on_timer_timeout() -> void:
	owner.max_speed = Values.player_max_speed
