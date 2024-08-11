extends Node2D
class_name ProgressionManager

@export var exp_bar: ProgressBar
@export var skill_button: TextureButton

@export var skill_category_button: HBoxContainer
@export var turret_skill_button: HBoxContainer
@export var rocket_skill_button: HBoxContainer
@export var laser_skill_button: HBoxContainer
@export var base_skill_button: HBoxContainer

var exp: int
var level: int
var base_exp_needed: int
var skill_points: int
var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	skill_button.set_visible(false)
	skill_category_button.set_visible(false)
	turret_skill_button.set_visible(false)
	rocket_skill_button.set_visible(false)
	laser_skill_button.set_visible(false)
	base_skill_button.set_visible(false)
	
	skill_points = 0
	base_exp_needed = 100
	level = 1
	exp = 0
	exp_bar.max_value = base_exp_needed + level * 10
	exp_bar.value = 0

func get_exp(value: int) -> void:
	var exp_needed: int = base_exp_needed + level * 10
	if exp + value >= exp_needed:
		exp = exp + value - exp_needed
		level += 1
		skill_points += 1
		skill_button.set_visible(true)
		exp_bar.max_value = exp_needed
		player.set_stats()
	else:
		exp += value
	exp_bar.value = exp

func select_skill(buttons: HBoxContainer) -> void:
	skill_points -= 1
	if skill_points == 0:
		buttons.set_visible(false)
		skill_category_button.set_visible(false)
		skill_button.set_visible(false)
	player.set_stats()

func _on_skill_button_pressed():
	skill_button.set_visible(false)
	skill_category_button.set_visible(true)

func _on_turret_pressed():
	turret_skill_button.set_visible(true)
	rocket_skill_button.set_visible(false)
	laser_skill_button.set_visible(false)
	base_skill_button.set_visible(false)
func _on_rocket_pressed():
	turret_skill_button.set_visible(false)
	rocket_skill_button.set_visible(true)
	laser_skill_button.set_visible(false)
	base_skill_button.set_visible(false)
func _on_laser_pressed():
	turret_skill_button.set_visible(false)
	rocket_skill_button.set_visible(false)
	laser_skill_button.set_visible(true)
	base_skill_button.set_visible(false)
func _on_base_pressed():
	turret_skill_button.set_visible(false)
	rocket_skill_button.set_visible(false)
	laser_skill_button.set_visible(false)
	base_skill_button.set_visible(true)

func _on_turret_damage_pressed():
	Values.player_melee_gun_damage += 5
	select_skill(turret_skill_button)
func _on_turret_attack_speed_pressed():
	Values.player_melee_gun_cooldown = snapped(Values.player_melee_gun_cooldown * 0.9, 0.01)
	select_skill(turret_skill_button)
func _on_turret_range_pressed():
	Values.player_melee_gun_range = snapped(Values.player_melee_gun_cooldown * 1.2, 1)
	select_skill(turret_skill_button)

func _on_rocket_damage_pressed():
	Values.player_manual_gun_damage += 10
	select_skill(rocket_skill_button)
func _on_rocket_attack_speed_pressed():
	Values.player_manual_gun_cooldown = snapped(Values.player_manual_gun_cooldown * 0.9, 0.01)
	select_skill(rocket_skill_button)

func _on_laser_damage_pressed():
	Values.player_ult_gun_damage += 20
	select_skill(laser_skill_button)
func _on_laser_attack_speed_pressed():
	Values.player_ult_gun_cooldown = snapped(Values.player_ult_gun_cooldown * 0.9, 0.01)
	select_skill(laser_skill_button)

func _on_acceleration_pressed():
	Values.player_acceleration = snapped(Values.player_acceleration * 1.1, 1)
	select_skill(base_skill_button)
func _on_speed_pressed():
	Values.player_max_speed = snapped(Values.player_max_speed * 1.1, 1)
	select_skill(base_skill_button)
func _on_max_health_pressed():
	Values.player_max_health += 20
	select_skill(base_skill_button)
func _on_health_regen_pressed():
	Values.player_health_regen += 0.1
	select_skill(base_skill_button)
