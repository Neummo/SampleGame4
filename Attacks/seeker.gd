extends Projectile
class_name Seeker

@export var gun_range_indicator: Area2D
@export var attack_area: Area2D
var steer_force: float = 10
var acceleration: Vector2 = Vector2.ZERO
var closest_enemy: Area2D
var player: CharacterBody2D
var no_return: bool
var scanning: bool = false
var has_to_return: bool = false

@onready var return_timer: Timer = $ReturnTimer

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	attack_type = "Physical"
	target = "Enemy"
	global_position = spawn_position
	global_rotation = spawn_rotation

func _physics_process(_delta):
	closest_enemy = player.closest_enemy
	acceleration += seek()
	steer_force = (speed * 0.01) ** 4
	velocity += acceleration * _delta
	velocity = velocity.limit_length(speed)
	rotation = velocity.angle()
	move_and_slide()
	if global_position.distance_to(player.global_position) >= Values.player_range * 10:
		Values.seeker_gun_active_amount -= 1
		set_physics_process(false)
		call_deferred("queue_free")

func seek():
	var steer: Vector2 = Vector2(0, -speed)
	var desired: Vector2 = Vector2.ZERO
	if closest_enemy == null:
		if return_timer.is_stopped() and not has_to_return:
			return_timer.start()
			scanning = true
		if scanning:
			desired = Vector2(0, -speed).rotated(spawn_rotation)
		else:
			desired = (player.global_position - global_position).normalized() * speed
	elif not no_return and attack_area.already_hit:
		desired = (player.global_position - global_position).normalized() * speed
	elif is_instance_valid(closest_enemy) and not closest_enemy.owner.dying:
		desired = (closest_enemy.global_position - global_position).normalized() * speed
	steer = (desired - velocity).normalized() * steer_force
	return steer

func _on_return_timer_timeout() -> void:
	scanning = false
	has_to_return = true
