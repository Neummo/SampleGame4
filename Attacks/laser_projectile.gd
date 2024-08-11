extends Projectile
class_name LaserProjectile

var player: CharacterBody2D
var shooting: bool = false

func _ready():
	damage = Values.player_melee_gun_damage
	speed = Values.player_melee_gun_speed
	player = get_tree().get_first_node_in_group("Player")
	global_position = spawn_position
	global_rotation = spawn_rotation
	target = "Enemy"

func _physics_process(_delta):
	velocity = Vector2(0, -speed).rotated(spawn_rotation)
	move_and_slide()
