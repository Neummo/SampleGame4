extends Node2D
class_name HealthComponent

@export var health_bar: ProgressBar
@export var possesor: String
@export var damage_flash_player: AnimationPlayer
var health: int
var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func damage(attack: Attack):
	health -= attack.attack_damage
	health_bar.health = health
	if health <= 0:
		if possesor == 'Player':
			get_tree().set_deferred("paused", true)
		else:
			owner.queue_free()
			player.progression_manager.get_currency(10)
	else:
		damage_flash_player.play("damage_flash")
