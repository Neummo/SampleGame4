extends Node2D
class_name ProgressionManager

@onready var weapon_slot: WeaponSlot = $UpgradeContainer/WeaponDisplay/WeaponSlot
@onready var weapon_slot_2: WeaponSlot = $UpgradeContainer/WeaponDisplay/WeaponSlot/WeaponSlot2
@onready var weapon_slot_3: WeaponSlot = $UpgradeContainer/WeaponDisplay/WeaponSlot/WeaponSlot3
@onready var weapon_slot_4: WeaponSlot = $UpgradeContainer/WeaponDisplay/WeaponSlot/WeaponSlot4
@onready var weapon_slot_5: WeaponSlot = $UpgradeContainer/WeaponDisplay/WeaponSlot/WeaponSlot5

@export var part_display: Control
@export var upgrade_menu: Control
@export var repair_button: UpgradeButton
@export var salvage_button: UpgradeButton
@onready var weapon_slot_buy: UpgradeButton = $UpgradeContainer/WeaponSlotBuy
@onready var bounty: TextureButton = $UpgradeContainer/Bounty
@onready var bounty_label: Label = $UpgradeContainer/Bounty/BountyLabel
@onready var bountry_price_label: Label = $UpgradeContainer/Bounty/BountryPriceLabel

@export var turret_unlock_button: BigUpgradeTreeButton
@export var turret_upgrade1_button: BigUpgradeTreeButton
@export var turret_upgrade11_button: BigUpgradeTreeButton
@export var turret_upgrade111_button: BigUpgradeTreeButton
@export var turret_upgrade21_button: BigUpgradeTreeButton
@export var turret_upgrade31_button: BigUpgradeTreeButton

@export var rocket_unlock_button: BigUpgradeTreeButton
@export var rocket_upgrade3_button: BigUpgradeTreeButton
@export var rocket_upgrade31_button: BigUpgradeTreeButton
@export var rocket_upgrade311_button: BigUpgradeTreeButton
@export var rocket_upgrade32_button: BigUpgradeTreeButton
@export var rocket_upgrade321_button: BigUpgradeTreeButton

@export var laser_unlock_button: BigUpgradeTreeButton
@export var laser_upgrade1_button: BigUpgradeTreeButton
@export var laser_upgrade11_button: BigUpgradeTreeButton
@export var laser_upgrade2_button: BigUpgradeTreeButton
@export var laser_upgrade21_button: BigUpgradeTreeButton

@export var field_unlock_button: BigUpgradeTreeButton
@export var field_upgrade1_button: BigUpgradeTreeButton
@export var field_upgrade11_button: BigUpgradeTreeButton
@export var field_upgrade12_button: BigUpgradeTreeButton
@export var field_upgrade13_button: BigUpgradeTreeButton

@export var seeker_unlock_button: BigUpgradeTreeButton
@export var seeker_upgrade3_button: BigUpgradeTreeButton
@export var seeker_upgrade31_button: BigUpgradeTreeButton
@export var seeker_upgrade311_button: BigUpgradeTreeButton
@export var seeker_upgrade312_button: BigUpgradeTreeButton

@onready var base_damage: BigUpgradeTreeButton = $UpgradeContainer/WeaponDisplay/BaseDamage
@onready var rate_of_fire: BigUpgradeTreeButton = $UpgradeContainer/WeaponDisplay/RateOfFire
@onready var projectile_speed: BigUpgradeTreeButton = $UpgradeContainer/WeaponDisplay/ProjectileSpeed
@onready var base_shields: BigUpgradeTreeButton = $UpgradeContainer/WeaponDisplay/BaseShields
@onready var damage: BigUpgradeTreeButton = $UpgradeContainer/WeaponDisplay/Damage
@onready var base_speed: BigUpgradeTreeButton = $UpgradeContainer/WeaponDisplay/BaseSpeed
@onready var base_acceleration: BigUpgradeTreeButton = $UpgradeContainer/WeaponDisplay/BaseAcceleration
@onready var shield_regen: BigUpgradeTreeButton = $UpgradeContainer/WeaponDisplay/ShieldRegen

var item_select: Control
var player: CharacterBody2D
var pricable: Array
var max_weapon_slots: int
var pause_start_time: int = 0
var pause_end_time: int = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("switch_menu"):
		switch_menu()

func _ready():
	for weapon in Values.weapons:
		if weapon.unlocked.call():
			max_weapon_slots += 1

	player = get_tree().get_first_node_in_group("Player")
	item_select = get_tree().get_first_node_in_group("ItemSelect")
	weapon_slot.init()
	
	pricable = [
		turret_unlock_button, turret_upgrade1_button, turret_upgrade11_button,
		turret_upgrade21_button, turret_upgrade31_button, turret_upgrade111_button,
		
		rocket_unlock_button, rocket_upgrade3_button, rocket_upgrade31_button,
		rocket_upgrade311_button, rocket_upgrade32_button, rocket_upgrade321_button,
		
		laser_unlock_button, laser_upgrade1_button, laser_upgrade11_button,
		laser_upgrade2_button, laser_upgrade21_button,
		
		field_unlock_button, field_upgrade1_button, field_upgrade11_button,
		field_upgrade12_button, field_upgrade13_button,
		
		seeker_unlock_button, seeker_upgrade3_button, seeker_upgrade31_button,
		seeker_upgrade311_button, seeker_upgrade312_button,
		
		base_damage, rate_of_fire, projectile_speed, base_shields,
		damage, base_speed, base_acceleration, shield_regen,
	]
	
	upgrade_menu.set_visible(false)
	for button in pricable:
		button.set_process(false)
	
	turret_unlock_button.set_properties(0, null)
	turret_upgrade1_button.set_properties(100, null)
	turret_upgrade11_button.set_properties(50, Values.mid_skill_prices)
	turret_upgrade111_button.set_properties(1000, null)
	turret_upgrade21_button.set_properties(1000, null)
	turret_upgrade31_button.set_properties(1000, null)
	
	rocket_unlock_button.set_properties(0, null)
	rocket_upgrade3_button.set_properties(50, null)
	rocket_upgrade31_button.set_properties(1000, null)
	rocket_upgrade311_button.set_properties(50, Values.mid_skill_prices)
	rocket_upgrade32_button.set_properties(1000, null)
	rocket_upgrade321_button.set_properties(50, Values.mid_skill_prices)
	
	laser_unlock_button.set_properties(0, null)
	laser_upgrade1_button.set_properties(100, null)
	laser_upgrade11_button.set_properties(50, Values.mid_skill_prices)
	laser_upgrade2_button.set_properties(100, null)
	laser_upgrade21_button.set_properties(50, Values.mid_skill_prices)
	
	field_unlock_button.set_properties(0, null)
	field_upgrade1_button.set_properties(100, null)
	field_upgrade11_button.set_properties(5, Values.low_skill_prices)
	field_upgrade12_button.set_properties(1000, null)
	field_upgrade13_button.set_properties(1000, null)
	
	seeker_unlock_button.set_properties(0, null)
	seeker_upgrade3_button.set_properties(50, null)
	seeker_upgrade31_button.set_properties(50, Values.mid_skill_prices)
	seeker_upgrade311_button.set_properties(1000, null)
	seeker_upgrade312_button.set_properties(1000, null)

	base_damage.set_properties(5, Values.low_skill_prices)
	rate_of_fire.set_properties(5, Values.low_skill_prices)
	projectile_speed.set_properties(5, Values.low_skill_prices)
	base_shields.set_properties(5, Values.low_skill_prices)
	damage.set_properties(5, Values.low_skill_prices)
	base_speed.set_properties(5, Values.low_skill_prices)
	base_acceleration.set_properties(5, Values.low_skill_prices)
	shield_regen.set_properties(5, Values.low_skill_prices)

	salvage_button.set_properties("Salvage", 1000, 1000, null)
	repair_button.set_properties("Repair", 0, 0, null)
	repair_button.price_label.set_text("")
	weapon_slot_buy.set_properties("Weapon Slot", 500, 500, max_weapon_slots)
	check_prices()

func get_currency(value: float) -> void:
	Values.currency += value
	player.stats.credits_label.set_text(str(Values.currency))
	check_prices()

func get_parts(value: int) -> void:
	Values.parts += value
	player.stats.parts_label.set_text(str(Values.parts))
	check_prices()
	part_display.check_prices()

func select_skill(button) -> void:
	button.on_select()
	check_prices()
	player.set_stats()

func check_prices() -> void:
	for button in pricable:
		button.check_price()
	salvage_button.check_price()
	weapon_slot_buy.check_price()
	bounty.check_price()

func _on_repair_pressed() -> void:
	player.heal()

func _on_salvage_pressed() -> void:
	item_select.activate()

func _on_bounty_pressed() -> void:
	check_prices()

func _on_weapon_slot_buy_pressed() -> void:
	for child in weapon_slot.get_children():
		if child is WeaponSlot and child.visible == false:
			child.weapon_tree = weapon_slot.weapon_tree
			child.weapon_tree_2 = weapon_slot.weapon_tree_2
			child.weapon_tree_3 = weapon_slot.weapon_tree_3
			child.weapon_tree_4 = weapon_slot.weapon_tree_4
			child.weapon_tree_5 = weapon_slot.weapon_tree_5
			child.init()
			child.visible = true
			Values.weapon_slots += 1
			select_skill(weapon_slot_buy)
			if Values.weapon_slots == max_weapon_slots:
				weapon_slot_buy.set_disabled(true)
				weapon_slot_buy.label.set_text("Max Weapon Slots")
				weapon_slot_buy.price_label.set_text("")
			return

func _on_turret_unlock_tree_button_pressed():
	Values.melee_gun_unlocked = true
	select_skill(turret_unlock_button)
func _on_turret_upgrade_1_tree_button_pressed():
	Values.player_melee_gun_speed *= 2
	select_skill(turret_upgrade1_button)
func _on_turret_upgrade_11_tree_button_pressed() -> void:
	Values.player_melee_gun_speed += 100
	select_skill(turret_upgrade11_button)
func _on_turret_upgrade_111_tree_button_pressed() -> void:
	Values.melee_gun_homing = true
	select_skill(turret_upgrade111_button)
func _on_turret_upgrade_21_tree_button_pressed() -> void:
	Values.player_melee_gun_damage += 50
	Values.turret_calliber_upgrade_unlocked = true
	select_skill(turret_upgrade21_button)
func _on_turret_upgrade_31_tree_button_pressed() -> void:
	Values.turret_second_upgrade_unlocked = true
	select_skill(turret_upgrade31_button)

func _on_rocket_unlock_tree_button_pressed():
	Values.manual_gun_unlocked = true
	select_skill(rocket_unlock_button)
func _on_rocket_upgrade_3_tree_button_pressed() -> void:
	Values.manual_gun_homing = true
	select_skill(rocket_upgrade3_button)
func _on_rocket_upgrade_31_tree_button_pressed() -> void:
	Values.player_manual_gun_speed += 200
	select_skill(rocket_upgrade31_button)
func _on_rocket_upgrade_311_tree_button_pressed() -> void:
	Values.player_manual_gun_speed += 50
	select_skill(rocket_upgrade311_button)
func _on_rocket_upgrade_32_tree_button_pressed() -> void:
	Values.player_manual_aoe_unlocked = true
	select_skill(rocket_upgrade32_button)
func _on_rocket_upgrade_321_tree_button_pressed() -> void:
	Values.player_manual_aoe_area += 20
	select_skill(rocket_upgrade321_button)

func _on_laser_unlock_tree_button_pressed():
	Values.ult_gun_unlocked = true
	select_skill(laser_unlock_button)
func _on_laser_upgrade_1_tree_button_pressed():
	Values.ult_gun_aoe_unlocked = true
	laser_upgrade2_button.lock("Locked")
	select_skill(laser_upgrade1_button)
func _on_laser_upgrade_11_tree_button_pressed() -> void:
	Values.ult_gun_aoe_radius += 20
	select_skill(laser_upgrade11_button)
func _on_laser_upgrade_2_tree_button_pressed() -> void:
	Values.ult_gun_pierce_unlocked = true
	laser_upgrade1_button.lock("Locked")
	select_skill(laser_upgrade2_button)
func _on_laser_upgrade_21_tree_button_pressed() -> void:
	Values.ult_gun_pierce_width += 20
	select_skill(laser_upgrade21_button)

func _on_field_unlock_tree_button_pressed() -> void:
	Values.area_field_unlocked = true
	select_skill(field_unlock_button)
func _on_field_upgrade_1_tree_button_pressed() -> void:
	Values.area_field_range += 100
	select_skill(field_upgrade1_button)
func _on_field_upgrade_11_tree_button_pressed() -> void:
	Values.area_field_2x_enter_unlocked = true
	field_upgrade12_button.lock("Locked")
	field_upgrade13_button.lock("Locked")
	select_skill(field_upgrade11_button)
func _on_field_upgrade_12_tree_button_pressed() -> void:
	Values.area_field_range += 200
	field_upgrade11_button.lock("Locked")
	field_upgrade13_button.lock("Locked")
	select_skill(field_upgrade12_button)
func _on_field_upgrade_13_tree_button_pressed() -> void:
	Values.area_field_4x_exit_unlocked = true
	field_upgrade11_button.lock("Locked")
	field_upgrade12_button.lock("Locked")
	select_skill(field_upgrade13_button)

func _on_seeker_unlock_tree_button_pressed() -> void:
	Values.seeker_gun_unlocked = true
	select_skill(seeker_unlock_button)
func _on_seeker_upgrade_3_tree_button_pressed() -> void:
	Values.seeker_gun_speed *= 2
	select_skill(seeker_upgrade3_button)
func _on_seeker_upgrade_31_tree_button_pressed() -> void:
	Values.seeker_gun_damage += 10
	select_skill(seeker_upgrade31_button)
func _on_seeker_upgrade_311_tree_button_pressed() -> void:
	Values.seeker_gun_amount += 1
	select_skill(seeker_upgrade311_button)
func _on_seeker_upgrade_312_tree_button_pressed() -> void:
	Values.seeker_gun_no_return_unlocked = true
	select_skill(seeker_upgrade312_button)

func _on_base_damage_pressed() -> void:
	Values.player_melee_gun_damage += 5
	Values.player_manual_gun_damage += 5
	Values.player_ult_gun_damage += 5
	Values.area_field_damage += 5
	Values.seeker_gun_damage += 5
	select_skill(base_damage)
func _on_rate_of_fire_pressed() -> void:
	Values.attack_speed_modifier += 0.05
	select_skill(rate_of_fire)
func _on_projectile_speed_pressed() -> void:
	Values.projectile_speed_modifier += 0.1
	select_skill(projectile_speed)
func _on_base_shields_pressed() -> void:
	Values.player_max_health += 10
	select_skill(base_shields)
func _on_damage_pressed() -> void:
	Values.player_damage_multiplier += 0.1
	select_skill(damage)
func _on_base_speed_pressed() -> void:
	Values.player_max_speed += 10
	select_skill(base_speed)
func _on_base_acceleration_pressed() -> void:
	Values.player_acceleration += 10
	select_skill(base_acceleration)
func _on_shield_regen_pressed() -> void:
	Values.player_hps += 1
	select_skill(shield_regen)

func _on_progression_panel_pressed() -> void:
	switch_menu()

func switch_menu() -> void:
	if not upgrade_menu.is_visible():
		upgrade_menu.set_visible(true)
		for button in pricable:
			button.set_process(true)
		if Values.zone == 0:
			repair_button.set_disabled(false)
		else:
			repair_button.set_disabled(true)
		get_tree().set_deferred("paused", true)
		pause_start_time = Time.get_ticks_msec()
	else:
		upgrade_menu.set_visible(false)
		for button in pricable:
			button.set_process(false)
		pause_end_time = Time.get_ticks_msec()
		get_tree().set_deferred("paused", false)
	
