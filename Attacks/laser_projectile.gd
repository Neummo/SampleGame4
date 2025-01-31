extends Projectile
class_name LaserProjectile

var player: CharacterBody2D
var shooting: bool = false
var homing: bool = false
var closest_enemy: Area2D
var accel: Vector2
@export var sprite: Sprite2D
@export var shape: CollisionShape2D

func _ready():
	attack_type = "Energy"
	damage = Values.player_melee_gun_damage
	speed = Values.player_melee_gun_speed * 15 * (0.8 + (0.2 * Values.projectile_speed_modifier))
	player = get_tree().get_first_node_in_group("Player")
	global_position = spawn_position
	global_rotation = spawn_rotation
	target = "Enemy"

func _physics_process(_delta):
	if homing:
		velocity = seek() * _delta 
		rotation = velocity.angle() + 1.57079633
	else:
		velocity = Vector2(0, -speed).rotated(spawn_rotation) * _delta
	velocity = velocity.limit_length(speed)
	move_and_slide()

func seek():
	var steer: Vector2 = Vector2(0, -speed).rotated(rotation)
	if is_instance_valid(closest_enemy):
		if closest_enemy.owner.dying:
			return Vector2(0, -speed).rotated(steer.angle() + 1.57079633)
		var desired = (closest_enemy.global_position - global_position).normalized() * speed
		steer = (desired - velocity).normalized() * 500
	return Vector2(0, -speed).rotated(steer.angle() + 1.57079633)
