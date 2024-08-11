extends Node2D

@export var spawn_timer: Timer

var player: CharacterBody2D
var viewport_size: Vector2

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	viewport_size = get_viewport().get_visible_rect().size

func spawn_enemy(count: int) -> void:
	for n in count:
		var enemy = load("res://enemy.tscn")
		var instance = enemy.instantiate()
		instance.global_position = get_random_position_offscreen()
		get_tree().current_scene.add_child.call_deferred(instance)

func get_random_position_offscreen():
	var randx
	var randy
	var distance_outside_screen: int = 100
	var screensize = get_viewport_rect().size
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	
	if rng.randi() % 2 == 0:
		# spawn at top or bottom
		randx = int(rng.randi_range(player.global_position.x - screensize.x, player.global_position.x + screensize.x))
		randy = player.global_position.y - screensize.y if rng.randi() % 2 == 0 else player.global_position.y + screensize.y
	else:
		# spawn at left or right
		randy = int(rng.randi_range(player.global_position.y - screensize.y, player.global_position.y + screensize.y))
		randx = player.global_position.x - screensize.x if rng.randi() % 2 == 0 else player.global_position.x + screensize.x
	return Vector2(randx, randy)

func _on_spawn_timer_timeout() -> void:
	spawn_enemy(1)
