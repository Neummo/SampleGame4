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
var time_label: Label
var pm: Node2D

@onready var game_start_time: int = Time.get_ticks_msec()
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
	time_label = get_tree().get_first_node_in_group("TimeLabel")
	pm = get_tree().get_first_node_in_group("pm")
	draw_zones()

func _process(_delta: float) -> void:
	time()

func time() -> void:
	var current_time : int = Time.get_ticks_msec() - (game_start_time + (pm.pause_end_time - pm.pause_start_time))
	var minutes = int(floor(current_time / 1000 / 60))
	Values.minutes_elapsed = minutes
	var seconds = int(floor(current_time / 1000 % 60))
	if minutes < 10:
		minutes = "0"+str(minutes)
	if seconds < 10:
		seconds = "0"+str(seconds)
	time_label.set_text(str(minutes)+":"+str(seconds))

func draw_zones() -> void:
	draw_zone_limit(first, 500)
	for k in range(1, zones.size() - 1):
		var line: Line2D = zones[k]
		draw_zone_limit(line, k * 10000)

func draw_zone_limit(line: Line2D, distance: float) -> void:
	for i in range(0, 361):
		var angle: float = deg_to_rad(1.0 * i)
		var s: float = sin(angle)
		var c: float = cos(angle)
		var radius: float = distance
		var point: Vector2 = Vector2(s * radius, c * radius)
		line.add_point(point)

func spawn_bounty(level: int) -> void:
	var scene = load("res://Enemies/bounty_1.tscn")
	var instance = scene.instantiate()
	instance.global_position = get_random_position_offscreen(false, true, level)
	get_tree().current_scene.add_child.call_deferred(instance)
	await get_tree().physics_frame
	await get_tree().process_frame

func spawn_boss(_level: int) -> void:
	init_enemy(load("res://Enemies/boss_1.tscn"))

func spawn_enemy(zone: int) -> void:
	Values.zone = zone
	if zone == 0 or get_tree().get_nodes_in_group('Grunt').size() >= 20 + zone:
		return
	Values.enemy_acceleration = 100 + zone
	Values.enemy_speed = 100 + zone
	Values.enemy_health = int(floor((((50 * zone) + 1) / 2)))
	Values.enemy_damage = int(floor(((5 + zone) / 2)))
	init_neutral(load("res://Neutral/asteroid.tscn"))
	for i in int(floor((zone / 10) + 1)):
		init_enemy(load("res://Enemies/enemy_1.tscn"))
	if zone >= 5:
		init_enemy(load("res://Enemies/enemy.tscn"))
	if zone >= 10:
		init_enemy(load("res://Enemies/enemy_3.tscn"))
	if zone >= 20:
		init_enemy(load("res://Enemies/enemy_4.tscn"))
	if zone >= 30:
		init_enemy(load("res://Enemies/enemy_5.tscn"))

func init_enemy(enemy_scene: Resource) -> void:
	var instance = enemy_scene.instantiate()
	instance.global_position = get_random_position_offscreen()
	get_tree().current_scene.add_child.call_deferred(instance)

func init_neutral(scene: Resource) -> void:
	if Values.neutral_count > 15:
		return
	var asd = get_random_position_offscreen(true)
	var instance = scene.instantiate()
	instance.global_position = asd
	instance.cluster_lead = true
	get_tree().current_scene.add_child.call_deferred(instance)
	instance = scene.instantiate()
	instance.global_position = asd + Vector2(randi_range(50, 300), randi_range(50, 300))
	get_tree().current_scene.add_child.call_deferred(instance)
	instance = scene.instantiate()
	instance.global_position = asd + Vector2(randi_range(50, 300), randi_range(-300, -50))
	get_tree().current_scene.add_child.call_deferred(instance)
	instance = scene.instantiate()
	instance.global_position = asd + Vector2(randi_range(-300, -50), randi_range(50, 300))
	get_tree().current_scene.add_child.call_deferred(instance)
	instance = scene.instantiate()
	instance.global_position = asd + Vector2(randi_range(-300, -50), randi_range(-300, -50))
	get_tree().current_scene.add_child.call_deferred(instance)
	Values.neutral_count += 5

func get_player_distance() -> float:
	return snapped(global_position.distance_to(player.global_position), 1)

func get_random_position_offscreen(neutral: bool = false, bounty: bool = false, bounty_level: int = 1):
	var randx
	var randy
	var screensize
	if neutral:
		screensize = get_viewport_rect().size
	elif bounty:
		screensize = Vector2(bounty_level * 10000, bounty_level * 10000)
	else:
		screensize = get_viewport_rect().size * 2
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
	if distance < 500:
		Values.zone = 0
		return
	var zone: int = int(floor(ceil(distance / 10000) + int(floor(Values.minutes_elapsed / 2))))
	spawn_enemy(zone)

func _on_boss_timer_timeout() -> void:
	spawn_boss(Values.zone)
