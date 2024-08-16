extends Node2D

@export var spawn_timer: Timer
@export var first: Line2D
@export var second: Line2D
@export var third: Line2D
@export var fourth: Line2D
@export var fifth: Line2D
@export var sixth: Line2D
@export var seventh: Line2D
@export var eighth: Line2D
@export var ninth: Line2D
@export var tenth: Line2D

var player: CharacterBody2D
var viewport_size: Vector2
@onready var zones: Array = [
	first,
	second,
	third,
	fourth,
	fifth,
	sixth,
	seventh,
	eighth,
	ninth,
	tenth,
]

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	viewport_size = get_viewport().get_visible_rect().size
	draw_zones()

func draw_zones() -> void:
	draw_zone_limit(first, 300)
	for k in range(1, zones.size() - 1):
		var line: Line2D = zones[k]
		draw_zone_limit(line, k * 1000)

func draw_zone_limit(line: Line2D, distance: float) -> void:
	for i in range(0, 361):
		var angle: float = deg_to_rad(1.0 * i)
		var s: float = sin(angle)
		var c: float = cos(angle)
		var radius: float = distance
		var point: Vector2 = Vector2(s * radius, c * radius)
		line.add_point(point)

func spawn_enemy(count: int, zone: int) -> void:
	if zone == 0:
		return
	Values.enemy_acceleration = 50 * zone
	Values.enemy_speed = 50 * zone
	Values.enemy_health = 100 * zone
	for n in count:
		var enemy: Resource
		if zone == 1:
			enemy = load("res://Enemies/enemy_1.tscn")
		else:
			enemy = load("res://Enemies/enemy.tscn")
		var instance = enemy.instantiate()
		instance.global_position = get_random_position_offscreen()
		get_tree().current_scene.add_child.call_deferred(instance)

func get_player_distance() -> float:
	return snapped(global_position.distance_to(player.global_position), 1)

func get_random_position_offscreen():
	var randx
	var randy
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
	var distance: float = get_player_distance()
	var zone: int 
	if distance < 300:
		zone = 0
		Values.safe_zone = true
	if distance >= 300 and distance < 1000:
		zone = 1
	elif distance >= 1000:
		zone = ceil(distance / 1000)
	spawn_enemy(1, zone)
