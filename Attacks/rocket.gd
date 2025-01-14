extends Projectile
class_name Rocket

var acceleration: float = 200

func _ready():
	target = "Enemy"
	damage = Values.player_manual_gun_damage
	speed = Values.player_manual_gun_speed * Values.projectile_speed_modifier
	global_position = spawn_position
	global_rotation = spawn_rotation

func _physics_process(_delta):
	velocity += Vector2(0, -acceleration).rotated(spawn_rotation) * _delta
	velocity = velocity.limit_length(speed)
	move_and_slide()
