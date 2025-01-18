extends Projectile
class_name EnemyRocketHoming

var steer_force: float = 5
var acceleration: Vector2 = Vector2.ZERO
var player: CharacterBody2D
var start_seeking: bool = false
@onready var timer: Timer = $Timer
@onready var lifespan: Timer = $Lifespan

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	target = "Player"
	damage = Values.enemy_damage * 2
	speed = Values.enemy_projectile_speed
	global_position = spawn_position
	global_rotation = spawn_rotation
	lifespan.start()
	timer.start()

func _physics_process(_delta):
	acceleration += seek()
	velocity += acceleration * _delta
	velocity = velocity.limit_length(speed)
	rotation = velocity.angle() + 1.57079633
	move_and_slide()

func seek():
	var steer: Vector2 = Vector2(0, -speed).rotated(spawn_rotation)
	if start_seeking:
		var desired = (player.global_position - global_position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _on_lifespan_timeout() -> void:
	queue_free()

func _on_timer_timeout() -> void:
	start_seeking = true
