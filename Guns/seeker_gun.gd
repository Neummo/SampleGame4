extends Gun
class_name SeekerGun

@onready var gun_timer: Timer = $GunTimer

var amount: int
var speed: float
var damage: int
var no_return: bool = false
var gun_switch: bool = true

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	update_stats()

func update_stats() -> void:
	amount = Values.seeker_gun_amount
	speed = Values.seeker_gun_speed * Values.projectile_speed_modifier
	damage = Values.seeker_gun_damage
	no_return = Values.seeker_gun_no_return_unlocked
	
func shoot():
	if !gun_switch:
		return
	while Values.seeker_gun_active_amount < amount and gun_timer.is_stopped() and is_instance_valid(player.closest_enemy):
		var angle = global_position.direction_to(player.closest_enemy.global_position).angle() + 1.57079633
		gun_timer.start()
		await gun_timer.timeout
		Values.seeker_gun_active_amount += 1
		spawn_projectile(angle)

func spawn_projectile(angle: float):
	var projectile = load("res://Attacks/seeker.tscn")
	var instance = projectile.instantiate()
	instance.spawn_rotation = angle
	instance.damage = damage
	instance.speed = speed
	instance.no_return = no_return
	instance.target = "Enemy"
	instance.spawn_position = player.global_position
	get_tree().current_scene.add_child.call_deferred(instance)

func toggle_gun():
	gun_switch = !gun_switch

	
