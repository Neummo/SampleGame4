extends Gun
class_name BigGun

@export var big_gun_area_beam: AreaBeam
@export var big_gun_laser: Laser
@export var big_gun_timer: Timer

@onready var big_guns: Dictionary = {
	big_gun_area_beam: false,
	big_gun_laser: true,
}

var closest_enemy: Area2D = null
var big_gun = null

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	cooldown_passed = true
	big_gun = get_big_gun()
	update_stats()

func update_stats():
	big_gun_timer.set_wait_time(Values.player_ult_gun_cooldown / Values.attack_speed_modifier)
	if Values.ult_gun_pierce_unlocked:
		big_gun = big_gun_area_beam
		big_gun.shape.get_shape().size.y = Values.ult_gun_pierce_width
		big_gun.shape.get_shape().size.x = Values.player_range
		big_gun.shape.position.x = Values.player_range / 2
	elif Values.ult_gun_aoe_unlocked:
		big_gun.is_aoe = true
		big_gun.aoe_shape.get_shape().radius = Values.ult_gun_aoe_radius
	big_gun.damage = Values.player_ult_gun_damage

func shoot():
	if cooldown_passed:
		var angle: float = player.body.rotation
		if player.closest_enemy:
			angle = player.body.global_position.direction_to(closest_enemy.global_position).angle()
		big_gun.rotation = angle
		cooldown_passed = false
		big_gun.set_is_casting(true)
		big_gun_timer.start()
		
func auto_shoot():
	if cooldown_passed and big_gun and player.closest_enemy:
		var angle: float = player.body.global_position.direction_to(player.closest_enemy.global_position).angle()
		big_gun.rotation = angle
		big_gun.closest_enemy = player.closest_enemy
		cooldown_passed = false
		big_gun.set_is_casting(true)
		big_gun_timer.start()

func get_big_gun():
	for gun in big_guns:
		if big_guns[gun]:
			return gun

func _on_big_gun_timer_timeout():
	cooldown_passed = true
