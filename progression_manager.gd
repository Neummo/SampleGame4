extends Node2D
class_name ProgressionManager

@export var skill_button: Control
@export var skill_button_label: Label

@export var skill_category_button: HBoxContainer

@export var turret_category_button: TextureButton
@export var turret_skill_button: Control
@export var turret_dmg_button: UpgradeButton
@export var turret_cd_button: UpgradeButton

@export var rocket_category_button: TextureButton
@export var rocket_skill_button: Control
@export var rocket_dmg_button: UpgradeButton
@export var rocket_cd_button: UpgradeButton

@export var laser_category_button: TextureButton

@export var laser_skill_button: Control
@export var laser_dmg_upgrade: Control
@export var laser_cd_upgrade: Control
@export var laser_aoe_upgrade: Control
@export var laser_wid_upgrade: Control

@export var laser_dmg_button: UpgradeButton
@export var laser_cd_button: UpgradeButton
@export var laser_aoe_button: UpgradeButton
@export var laser_wid_button: UpgradeButton

@export var base_skill_button: Control
@export var base_acl_button: UpgradeButton
@export var base_spd_button: UpgradeButton
@export var base_hp_button: UpgradeButton

@export var upgrade_menu: Control
#@export var turret_upgrade_button: BigUpgradeButton
#@export var rocket_upgrade_button: BigUpgradeButton
#@export var laser_upgrade_button: BigUpgradeButton
@export var repair_button: UpgradeButton

@export var turret_unlock_button: BigUpgradeTreeButton
@export var rocket_unlock_button: BigUpgradeTreeButton
@export var laser_unlock_button: BigUpgradeTreeButton

@export var turret_unlock: Control
@export var rocket_unlock: Control
@export var laser_unlock: Control
@export var turret_upgrade: Control
@export var rocket_upgrade: Control
@export var laser_upgrade: Control

@export var turret_upgrade1_button: BigUpgradeTreeButton
@export var rocket_upgrade1_button: BigUpgradeTreeButton
@export var laser_upgrade11_button: BigUpgradeTreeButton
@export var laser_upgrade12_button: BigUpgradeTreeButton

var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	skill_category_button.set_visible(false)
	turret_skill_button.set_visible(false)
	rocket_skill_button.set_visible(false)
	laser_skill_button.set_visible(false)
	laser_aoe_upgrade.set_visible(false)
	laser_wid_upgrade.set_visible(false)
	base_skill_button.set_visible(false)
	upgrade_menu.set_visible(false)
	
	turret_dmg_button.set_properties("+5 Turret damage", 50, 10, null)
	turret_cd_button.set_properties("10% Turret reload speed", 50, 50, 10)
	rocket_dmg_button.set_properties("+10 Rocket damage", 50, 10, null)
	rocket_cd_button.set_properties("10% Rocket reload speed", 50, 50, 10)
	laser_dmg_button.set_properties("+20 Laser damage", 50, 10, null)
	laser_cd_button.set_properties("10% Laser reload speed", 50, 50, 10)
	laser_aoe_button.set_properties("+10% Area", 50, 50, 10)
	laser_wid_button.set_properties("+10% Laser width", 50, 50, 10)
	base_acl_button.set_properties("+10 Acceleration", 50, 10, null)
	base_spd_button.set_properties("+10 Max speed", 50, 10, null)
	base_hp_button.set_properties("+20 Max health", 50, 10, null)
	
	turret_unlock_button.set_properties("Unlock Turret", 0)
	rocket_unlock_button.set_properties("Unlock Rocket", 50)
	laser_unlock_button.set_properties("Unlock Laser", 50)
	
	turret_upgrade1_button.set_properties("+100% bullet speed", 50)
	rocket_upgrade1_button.set_properties("Homing rockets", 50)
	laser_upgrade11_button.set_properties("AoE damage on impact", 50)
	laser_upgrade12_button.set_properties("Piercing laser", 50)
	turret_upgrade.set_visible(false)
	rocket_upgrade.set_visible(false)
	laser_upgrade.set_visible(false)

	#turret_upgrade_button.init([
	#	{
	#		"label_text": "+100% bullet speed",
	#		"price": 50,
	#		"effect": func (): Values.player_melee_gun_speed *= 2
	#	},
	#])
	#rocket_upgrade_button.init([
	#	{
	#		"label_text": "Unlock rockets",
	#		"price": 50,
	#		"effect": func (): Values.manual_gun_unlocked = true
	#	},
	#	{
	#		"label_text": "Homing rockets",
	#		"price": 50,
	#		"effect": func (): Values.manual_gun_homing = true
	#	},
	#])
	#laser_upgrade_button.init([
	#	{
	#		"label_text": "Unlock laser",
	#		"price": 50,
	#		"effect": func (): Values.ult_gun_unlocked = true
	#	},
	#	{
	#		"label_text": "Damage on impact laser",
	#		"price": 50,
	#		"effect": func (): Values.ult_gun_aoe_unlocked = true
	#	},
	#	{
	#		"label_text": "Piercing laser",
	#		"price": 50,
	#		"effect": func (): Values.ult_gun_pierce_unlocked = true
	#	},
	#])
	repair_button.set_properties("Repair", 0, 0, null)
	
	check_prices()

func get_currency(value: int) -> void:
	Values.currency += value
	player.stats.currency_label.set_text(str(Values.currency))
	skill_button_label.set_text(str(Values.currency))
	check_prices()

func select_skill(button) -> void:
	button.on_select()
	check_prices()
	player.set_stats()

func check_prices() -> void:
	turret_dmg_button.check_price()
	turret_cd_button.check_price()
	rocket_dmg_button.check_price()
	rocket_cd_button.check_price()
	laser_dmg_button.check_price()
	laser_cd_button.check_price()
	laser_aoe_button.check_price()
	laser_wid_button.check_price()
	base_acl_button.check_price()
	base_spd_button.check_price()
	base_hp_button.check_price()
	#turret_upgrade_button.check_price()
	#rocket_upgrade_button.check_price()
	#laser_upgrade_button.check_price()
	repair_button.check_price()
	turret_unlock_button.check_price()
	turret_upgrade1_button.check_price()
	rocket_unlock_button.check_price()
	rocket_upgrade1_button.check_price()
	laser_upgrade11_button.check_price()
	laser_upgrade12_button.check_price()

func _on_skill_button_pressed():
	if skill_category_button.is_visible():
		skill_category_button.set_visible(false)
		turret_skill_button.set_visible(false)
		rocket_skill_button.set_visible(false)
		laser_skill_button.set_visible(false)
		base_skill_button.set_visible(false)
	else:
		skill_category_button.set_visible(true)
		if Values.melee_gun_unlocked:
			turret_category_button.set_visible(true)
		else:
			turret_category_button.set_visible(false)
		if Values.manual_gun_unlocked:
			rocket_category_button.set_visible(true)
		else:
			rocket_category_button.set_visible(false)
		if Values.ult_gun_unlocked:
			laser_category_button.set_visible(true)
		else:
			laser_category_button.set_visible(false)

func _on_turret_pressed():
	if Values.melee_gun_unlocked:
		turret_skill_button.set_visible(true)
		rocket_skill_button.set_visible(false)
		laser_skill_button.set_visible(false)
		base_skill_button.set_visible(false)
func _on_rocket_pressed():
	if Values.manual_gun_unlocked:
		turret_skill_button.set_visible(false)
		rocket_skill_button.set_visible(true)
		laser_skill_button.set_visible(false)
		base_skill_button.set_visible(false)
func _on_laser_pressed():
	if Values.ult_gun_unlocked:
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
	select_skill(turret_dmg_button)
func _on_turret_attack_speed_pressed():
	Values.player_melee_gun_cooldown = snapped(Values.player_melee_gun_cooldown * 0.9, 0.01)
	select_skill(turret_cd_button)

func _on_rocket_damage_pressed():
	Values.player_manual_gun_damage += 10
	select_skill(rocket_dmg_button)
func _on_rocket_attack_speed_pressed():
	Values.player_manual_gun_cooldown = snapped(Values.player_manual_gun_cooldown * 0.9, 0.01)
	select_skill(rocket_cd_button)

func _on_laser_damage_pressed():
	Values.player_ult_gun_damage += 20
	select_skill(laser_dmg_button)
func _on_laser_attack_speed_pressed():
	Values.player_ult_gun_cooldown = snapped(Values.player_ult_gun_cooldown * 0.9, 0.01)
	select_skill(laser_cd_button)
func _on_laser_aoe_pressed():
	Values.ult_gun_aoe_radius += 5
	select_skill(laser_aoe_button)
func _on_laser_width_pressed():
	Values.ult_gun_pierce_width += 5
	select_skill(laser_wid_button)

func _on_acceleration_pressed():
	Values.player_acceleration += 10
	select_skill(base_acl_button)
func _on_speed_pressed():
	Values.player_max_speed += 10
	select_skill(base_spd_button)
func _on_max_health_pressed():
	Values.player_max_health += 20
	select_skill(base_hp_button)



#func _on_turret_upgrade_button_pressed():
#	select_skill(turret_upgrade_button)
#func _on_rocket_upgrade_button_pressed():
#	select_skill(rocket_upgrade_button)
#func _on_laser_upgrade_button_pressed():
#	select_skill(laser_upgrade_button)
func _on_repair_pressed():
	player.heal()

func _on_turret_unlock_tree_button_pressed():
	Values.melee_gun_unlocked = true
	select_skill(turret_unlock_button)
	turret_upgrade.set_visible(true)
	turret_category_button.set_visible(true)
func _on_rocket_unlock_tree_button_pressed():
	Values.manual_gun_unlocked = true
	select_skill(rocket_unlock_button)
	rocket_upgrade.set_visible(true)
	rocket_category_button.set_visible(true)
func _on_laser_unlock_tree_button_pressed():
	Values.ult_gun_unlocked = true
	select_skill(laser_unlock_button)
	laser_upgrade.set_visible(true)
	laser_category_button.set_visible(true)
func _on_turret_upgrade_1_tree_button_pressed():
	Values.player_melee_gun_speed *= 2
	select_skill(turret_upgrade1_button)
func _on_rocket_upgrade_1_tree_button_pressed():
	Values.manual_gun_homing = true
	select_skill(rocket_upgrade1_button)
func _on_laser_upgrade_1_tree_button_pressed():
	Values.ult_gun_aoe_unlocked = true
	laser_upgrade12_button.lock("Unavailable")
	select_skill(laser_upgrade11_button)
	laser_aoe_upgrade.set_visible(true)
func _on_laser_upgrade_1_tree_button_2_pressed():
	Values.ult_gun_pierce_unlocked = true
	laser_upgrade11_button.lock("Unavailable")
	select_skill(laser_upgrade12_button)
	laser_wid_upgrade.set_visible(true)
