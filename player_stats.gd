extends Stat
class_name PlayerStats

@export var turret_damage_label: Label
@export var turret_reload_speed_label: Label
@export var turret_range_label: Label

@export var rocket_damage_label: Label
@export var rocket_reload_speed_label: Label

@export var laser_damage_label: Label
@export var laser_reload_speed_label: Label

@export var acceleration_label: Label
@export var max_speed_label: Label
@export var max_health_label: Label
@export var currency_label: Label

@export var coords: Label

var turret_damage: int
var turret_reload_speed: float
var turret_range: float

var rocket_damage: int
var rocket_reload_speed: float

var laser_damage: int
var laser_reload_speed: float

var currency: int

func set_stats(stats: Dictionary) -> void:
	acceleration = stats.acceleration
	max_speed = stats.max_speed
	max_health = stats.max_health
	currency = stats.currency
	
	turret_damage = stats.turret.damage
	turret_reload_speed = stats.turret.reload_speed
	turret_range = stats.turret.range
	
	rocket_damage = stats.rocket.damage
	rocket_reload_speed = stats.rocket.reload_speed
	
	laser_damage = stats.laser.damage
	laser_reload_speed = stats.laser.reload_speed
	
	reload_labels()

func reload_labels() -> void:
	turret_damage_label.set_text(str(turret_damage))
	turret_reload_speed_label.set_text(str(turret_reload_speed))
	turret_range_label.set_text(str(turret_range))

	rocket_damage_label.set_text(str(rocket_damage))
	rocket_reload_speed_label.set_text(str(rocket_reload_speed))

	laser_damage_label.set_text(str(laser_damage))
	laser_reload_speed_label.set_text(str(laser_reload_speed))

	acceleration_label.set_text(str(acceleration))
	max_speed_label.set_text(str(max_speed))
	max_health_label.set_text(str(max_health))
	currency_label.set_text(str(currency))
