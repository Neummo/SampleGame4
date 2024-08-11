extends CharacterBody2D

@export var shoot_timer: Timer
@export var ACCELERATION: float = 50.0
@export var MAX_SPEED: float = 50.0
@export var ROTATE_SPEED: float = 10

@export var health: HealthComponent
var player: CharacterBody2D
var shooting: bool = false
var directions: Array = [-ACCELERATION, ACCELERATION]
var direction: int

@export var health_bar: ProgressBar
@export var body: Node2D

func _ready():
	health.MAX_HEALTH = Values.enemy_health
	health_bar.init_health(Values.enemy_health) 
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	player = get_tree().get_first_node_in_group("Player")
	direction = directions[randi() % directions.size()]
	
func _physics_process(delta):
	rotate_to_target(player, delta)
	behavior(delta)
	move_and_slide()

func shoot():
	var projectile = load("res://Attacks/enemy_laser_projectile.tscn")
	var instance = projectile.instantiate()
	instance.spawn_position = global_position + Vector2(5, 0).rotated(body.rotation)
	instance.spawn_rotation = body.rotation + 1.57079633
	get_tree().current_scene.add_child.call_deferred(instance)

func rotate_to_target(target, delta):
	var dir = (target.global_position - global_position)
	var angle_to = body.transform.x.angle_to(dir)
	body.rotate(sign(angle_to) * min(delta * ROTATE_SPEED, abs(angle_to)))
	
func behavior(delta: float) -> void:
	if abs(body.get_angle_to(player.global_position)) >= 0.17:
		if shooting:
			shooting = false
			shoot_timer.stop()
		velocity -= (Vector2(velocity.x, velocity.y) * delta)
	else:
		if global_position.distance_to(player.global_position) > Values.enemy_range and shooting:
			shooting = false
			shoot_timer.stop()
		elif not shooting:
			shooting = true
			shoot_timer.start()
		if global_position.distance_to(player.global_position) <= Values.enemy_range / 2:
			velocity += (Vector2(0, direction).rotated(body.rotation)).normalized() * delta * ACCELERATION
		else:
			velocity += (Vector2(ACCELERATION, 0).rotated(body.rotation)).normalized() * delta * ACCELERATION
	velocity = velocity.limit_length(MAX_SPEED)
	
func _on_shoot_timer_timeout():
	direction = directions[randi() % directions.size()]
	shoot()
