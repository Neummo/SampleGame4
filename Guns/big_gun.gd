extends Gun
class_name BigGun

@export var big_gun_area_beam: AreaBeam
@export var big_gun_laser: Laser
@export var big_gun_beam: Beam
@export var big_gun_timer: Timer
@export var range: Area2D

@onready var big_guns: Dictionary = {
	big_gun_area_beam: true,
	big_gun_laser: false,
	#big_gun_beam: false,
}

var closest_enemy: Area2D = null
var big_gun = null

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	cooldown_passed = true
	big_gun = get_big_gun()
	update_stats()

func update_stats():
	big_gun_timer.set_wait_time(Values.player_ult_gun_cooldown)
	big_gun.damage = Values.player_ult_gun_damage

func shoot():
	if cooldown_passed and big_gun:
		get_closest_enemy()
		var angle: float = player.body.rotation
		if closest_enemy:
			angle = player.body.global_position.direction_to(closest_enemy.global_position).angle()
		big_gun.rotation = angle
		cooldown_passed = false
		big_gun.set_is_casting(true)
		big_gun_timer.start()

func get_closest_enemy() -> Area2D:
	var overlapping_areas: Array[Area2D] = range.get_overlapping_areas()
	var min_distance: float
	closest_enemy = null
	for area in overlapping_areas:
		if area is HitboxComponent and area.possesor != "Player":
			var distance_to_enemy: float = player.global_position.distance_squared_to(area.global_position)
			if not closest_enemy:
				min_distance = player.global_position.distance_squared_to(area.global_position)
				closest_enemy = area
			if distance_to_enemy < min_distance:
				min_distance = distance_to_enemy
				closest_enemy = area
	return closest_enemy

func get_big_gun():
	for gun in big_guns:
		if big_guns[gun]:
			return gun

func _on_big_gun_timer_timeout():
	cooldown_passed = true
