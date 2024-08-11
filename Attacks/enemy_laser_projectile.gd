extends Projectile
class_name EnemyLaserProjectile

func _ready():
	target = "Player"
	damage = Values.enemy_damage
	speed = Values.enemy_projectile_speed
	global_position = spawn_position
	global_rotation = spawn_rotation

func _physics_process(delta):
	velocity = Vector2(0, -speed).rotated(spawn_rotation)
	move_and_slide()
