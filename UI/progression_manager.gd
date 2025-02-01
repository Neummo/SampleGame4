extends Node2D
class_name ProgressionManager

@onready var description: RichTextLabel = $UpgradeContainer/Description

@onready var currency_label: Label = $UpgradeContainer/UpgradeDisplay/Currency/CurrencyLabel
@onready var parts_label: Label = $UpgradeContainer/PartDisplay/Parts/PartsLabel
@onready var module_label: Label = $UpgradeContainer/WeaponDisplay/Modules/ModuleLabel

@onready var panel_transitions: AnimatedSprite2D = $PanelTransitions
@onready var weapons_tab: TextureButton = $UpgradeContainer/WeaponsTab
@onready var passive_tab: TextureButton = $UpgradeContainer/PassiveTab
@onready var upgrade_tab: TextureButton = $UpgradeContainer/UpgradeTab

@onready var weapon_slot: WeaponSlot = $UpgradeContainer/WeaponDisplay/WeaponSlot
@onready var weapon_slot_2: WeaponSlot = $UpgradeContainer/WeaponDisplay/WeaponSlot2
@onready var weapon_slot_3: WeaponSlot = $UpgradeContainer/WeaponDisplay/WeaponSlot3
@onready var weapon_slot_4: WeaponSlot = $UpgradeContainer/WeaponDisplay/WeaponSlot4
@onready var weapon_slot_5: WeaponSlot = $UpgradeContainer/WeaponDisplay/WeaponSlot5

@onready var weapon_display: Control = $UpgradeContainer/WeaponDisplay
@onready var upgrade_display: Control = $UpgradeContainer/UpgradeDisplay
@export var part_display: Control
@export var upgrade_menu: Control
@export var repair_button: UpgradeButton
@export var salvage_button: UpgradeButton
@onready var bounty: TextureButton = $UpgradeContainer/Bounty
@onready var bounty_label: Label = $UpgradeContainer/Bounty/BountyLabel
@onready var bountry_price_label: Label = $UpgradeContainer/Bounty/BountryPriceLabel

@export var turret_unlock_button: BigUpgradeTreeButton
@export var turret_upgrade1_button: BigUpgradeTreeButton
@export var turret_upgrade11_button: BigUpgradeTreeButton
@export var turret_upgrade111_button: BigUpgradeTreeButton
@export var turret_upgrade211_button: BigUpgradeTreeButton
@export var turret_upgrade311_button: BigUpgradeTreeButton
@export var turret_upgrade21_button: BigUpgradeTreeButton
@export var turret_upgrade31_button: BigUpgradeTreeButton

@export var rocket_unlock_button: BigUpgradeTreeButton
@export var rocket_upgrade3_button: BigUpgradeTreeButton
@export var rocket_upgrade31_button: BigUpgradeTreeButton
@export var rocket_upgrade311_button: BigUpgradeTreeButton
@export var rocket_upgrade32_button: BigUpgradeTreeButton
@export var rocket_upgrade321_button: BigUpgradeTreeButton
@export var rocket_upgrade33_button: BigUpgradeTreeButton
@export var rocket_upgrade34_button: BigUpgradeTreeButton

@export var laser_unlock_button: BigUpgradeTreeButton
@export var laser_upgrade1_button: BigUpgradeTreeButton
@export var laser_upgrade11_button: BigUpgradeTreeButton
@export var laser_upgrade2_button: BigUpgradeTreeButton
@export var laser_upgrade21_button: BigUpgradeTreeButton
@export var laser_upgrade3_button: BigUpgradeTreeButton
@export var laser_upgrade4_button: BigUpgradeTreeButton

@export var field_unlock_button: BigUpgradeTreeButton
@export var field_upgrade1_button: BigUpgradeTreeButton
@export var field_upgrade11_button: BigUpgradeTreeButton
@export var field_upgrade12_button: BigUpgradeTreeButton
@export var field_upgrade13_button: BigUpgradeTreeButton
@export var field_upgrade2_button: BigUpgradeTreeButton
@export var field_upgrade3_button: BigUpgradeTreeButton

@export var seeker_unlock_button: BigUpgradeTreeButton
@export var seeker_upgrade3_button: BigUpgradeTreeButton
@export var seeker_upgrade311_button: BigUpgradeTreeButton
@export var seeker_upgrade312_button: BigUpgradeTreeButton
@export var seeker_upgrade313_button: BigUpgradeTreeButton
@export var seeker_upgrade314_button: BigUpgradeTreeButton


@onready var base_damage: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/BaseDamage
@onready var rate_of_fire: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/RateOfFire
@onready var projectile_speed: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/ProjectileSpeed
@onready var base_shields: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/BaseShields
@onready var magnet: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/Magnet
@onready var base_speed: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/BaseSpeed
@onready var base_acceleration: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/BaseAcceleration
@onready var shield_regen: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/ShieldRegen

@onready var damage: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/BaseDamage/Damage
@onready var damage_b: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/BaseDamage/Damage/DamageB
@onready var damage_al: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/DamageAL
@onready var damage_ps: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/DamagePS
@onready var shields: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/BaseShields/Shields
@onready var magnet_p: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/Magnet/MagnetP
@onready var magnet_i: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/Magnet/MagnetP/MagnetI
@onready var damage_red: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/ShieldRegen/DamageRed
@onready var damage_red_b: BigUpgradeTreeButton = $UpgradeContainer/UpgradeDisplay/ShieldRegen/DamageRed/DamageRedB

var item_select: Control
var player: CharacterBody2D
var pricable: Array
var max_weapon_slots: int
var elimination_count: Array = [50, 550, 1550, 3550]
var item_button: TextureButton
var item_button_count: Label

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch_menu"):
		switch_menu()

func _ready():
	weapons_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/selected/33.png"))
	passive_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/unselected/32.png"))
	upgrade_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/unselected/34.png"))
	
	for weapon in Values.weapons:
		if weapon.unlocked.call():
			max_weapon_slots += 1

	player = get_tree().get_first_node_in_group("Player")
	item_button = get_tree().get_first_node_in_group("item_button")
	item_button_count = get_tree().get_first_node_in_group("item_button_count")
	item_select = get_tree().get_first_node_in_group("ItemSelect")

	weapon_slot.init()
	
	pricable = [
		turret_unlock_button, turret_upgrade1_button, turret_upgrade11_button,
		turret_upgrade211_button, turret_upgrade311_button, turret_upgrade111_button,
		
		rocket_unlock_button, rocket_upgrade3_button, rocket_upgrade31_button,
		rocket_upgrade311_button, rocket_upgrade32_button, rocket_upgrade321_button,
		
		laser_unlock_button, laser_upgrade1_button, laser_upgrade11_button,
		laser_upgrade2_button, laser_upgrade21_button,
		
		field_unlock_button, field_upgrade1_button, field_upgrade11_button,
		field_upgrade12_button, field_upgrade13_button,
		
		seeker_unlock_button, seeker_upgrade3_button, seeker_upgrade313_button,
		seeker_upgrade311_button, seeker_upgrade312_button,
		
		base_damage, rate_of_fire, projectile_speed, base_shields,
		magnet, base_speed, base_acceleration, shield_regen,
		
		damage,
		damage_b,
		damage_al,
		damage_ps,
		shields,
		magnet_p,
		magnet_i,
		damage_red,
		damage_red_b,
		
		turret_upgrade21_button,
		turret_upgrade31_button,
		rocket_upgrade33_button,
		rocket_upgrade34_button,
		laser_upgrade3_button,
		laser_upgrade4_button,
		field_upgrade2_button,
		field_upgrade3_button,
		seeker_upgrade314_button,
	]
	
	upgrade_menu.set_visible(false)
	for button in pricable:
		button.set_process(false)
	
	turret_unlock_button.set_properties(0, "00", null, true)
	turret_upgrade1_button.set_properties(5, "14", null, true)
	turret_upgrade11_button.set_properties(1, "14", Values.mid_skill_prices, true)
	turret_upgrade111_button.set_properties(5, "17", null, true)
	turret_upgrade211_button.set_properties(5, "11", null, true)
	turret_upgrade311_button.set_properties(5, "13", null, true)
	turret_upgrade21_button.set_properties(1, "06", Values.mid_skill_prices, true)
	turret_upgrade31_button.set_properties(1, "07", Values.mid_skill_prices, true)

	rocket_unlock_button.set_properties(0, "01", null, true)
	rocket_upgrade3_button.set_properties(1, "17", null, true)
	rocket_upgrade31_button.set_properties(5, "14", null, true)
	rocket_upgrade311_button.set_properties(1, "14", Values.mid_skill_prices, true)
	rocket_upgrade32_button.set_properties(5, "05", null, true)
	rocket_upgrade321_button.set_properties(1, "15", Values.mid_skill_prices, true)
	rocket_upgrade33_button.set_properties(1, "07", Values.mid_skill_prices, true)
	rocket_upgrade34_button.set_properties(1, "06", Values.mid_skill_prices, true)

	laser_unlock_button.set_properties(0, "02", null, true)
	laser_upgrade1_button.set_properties(5, "05", null, true)
	laser_upgrade11_button.set_properties(1, "15", Values.mid_skill_prices, true)
	laser_upgrade2_button.set_properties(5, "11", null, true)
	laser_upgrade21_button.set_properties(1, "15", Values.mid_skill_prices, true)
	laser_upgrade3_button.set_properties(1, "07", Values.mid_skill_prices, true)
	laser_upgrade4_button.set_properties(1, "06", Values.mid_skill_prices, true)

	field_unlock_button.set_properties(0, "04", null, true)
	field_upgrade1_button.set_properties(5, "15", null, true)
	field_upgrade11_button.set_properties(5, "18", null, true)
	field_upgrade12_button.set_properties(5, "15", null, true)
	field_upgrade13_button.set_properties(5, "19", null, true)
	field_upgrade2_button.set_properties(1, "06", Values.mid_skill_prices, true)
	field_upgrade3_button.set_properties(1, "15", Values.mid_skill_prices, true)

	seeker_unlock_button.set_properties(0, "03", null, true)
	seeker_upgrade3_button.set_properties(3, "14", null, true)
	seeker_upgrade313_button.set_properties(1, "06", Values.mid_skill_prices, true)
	seeker_upgrade311_button.set_properties(5, "12", null, true)
	seeker_upgrade312_button.set_properties(5, "24", null, true)
	seeker_upgrade314_button.set_properties(1, "14", Values.mid_skill_prices, true)

	base_damage.set_properties(5, "06", Values.base_skill_prices)
	rate_of_fire.set_properties(5, "07", Values.base_skill_prices)
	projectile_speed.set_properties(5, "14", Values.base_skill_prices)
	base_shields.set_properties(5, "25", Values.base_skill_prices)
	magnet.set_properties(5, "20", Values.base_skill_prices)
	base_speed.set_properties(5, "09", Values.base_skill_prices)
	base_acceleration.set_properties(5, "08", Values.base_skill_prices)
	shield_regen.set_properties(5, "36", Values.base_skill_prices)
	damage.set_properties(20000, "06", null)
	damage_b.set_properties(20000, "06", null)
	damage_al.set_properties(20000, "06", null)
	damage_ps.set_properties(20000, "06", null)
	shields.set_properties(20000, "25", null)
	magnet_p.set_properties(20000, "20", null)
	magnet_i.set_properties(20000, "20", null)
	damage_red.set_properties(20000, "27", null)
	damage_red_b.set_properties(20000, "27", null)
	
	salvage_button.set_properties("Salvage", 1000, 1000, null)
	repair_button.set_properties("Repair", 0, 0, null)
	repair_button.price_label.set_text("")
	check_prices()

func get_currency(value: float) -> void:
	Values.currency += value
	player.stats.credits_label.set_text(str(snappedf(Values.currency, 0.01)))
	check_prices()

func get_parts(value: int) -> void:
	Values.parts += value
	player.stats.parts_label.set_text(str(Values.parts))
	check_prices()
	part_display.check_prices()
	
func get_modules(value: int) -> void:
	Values.modules += value
	player.stats.modules_label.set_text(str(Values.modules))
	check_prices()
	
func get_salvages(value: int) -> void:
	Values.item_count += value
	item_button_count.set_text(str(Values.item_count))
	update_item_button()

func update_item_button() -> void:
	if Values.item_count > 0 and not item_button.is_visible():
		item_button.set_visible(true)
	if Values.item_count <= 0 and item_button.is_visible():
		item_button.set_visible(false)

func select_skill(button) -> void:
	button.on_select()
	check_prices()
	player.set_stats()
	module_label.set_text(str(Values.modules))
	currency_label.set_text(str(snappedf(Values.currency, 0.01)))

func check_prices() -> void:
	for button in pricable:
		button.check_price()
	salvage_button.check_price()
	bounty.check_price()

func _on_repair_pressed() -> void:
	player.heal()

func _on_salvage_pressed() -> void:
	item_select.priced = true
	item_select.activate()

func _on_turret_unlock_tree_button_pressed():
	Values.melee_gun_unlocked = true
	turret_unlock_button.description = turret_unlock_button.description.replace("Press to Unlock. ", "")
	select_skill(turret_unlock_button)
#func _on_turret_upgrade_1_tree_button_pressed():
	#Values.player_melee_gun_speed *= 2
	#select_skill(turret_upgrade1_button)
func _on_turret_upgrade_11_tree_button_pressed() -> void:
	Values.player_melee_gun_speed += 50
	select_skill(turret_upgrade11_button)
func _on_turret_upgrade_111_tree_button_pressed() -> void:
	Values.melee_gun_homing = true
	select_skill(turret_upgrade111_button)
func _on_turret_upgrade_211_tree_button_pressed() -> void:
	Values.turret_calliber_upgrade_unlocked = true
	select_skill(turret_upgrade211_button)
func _on_turret_upgrade_311_tree_button_pressed() -> void:
	Values.player_melee_gun_cooldown = Values.player_melee_gun_cooldown * 0.5
	select_skill(turret_upgrade311_button)
func _on_turret_upgrade_31_tree_button_pressed() -> void:
	Values.player_melee_gun_cooldown = Values.player_melee_gun_cooldown * 0.9
	select_skill(turret_upgrade31_button)
func _on_turret_upgrade_21_tree_button_pressed() -> void:
	Values.player_melee_gun_damage = int(floor(Values.player_melee_gun_damage * 1.1))
	select_skill(turret_upgrade21_button)

func _on_rocket_unlock_tree_button_pressed():
	Values.manual_gun_unlocked = true
	rocket_unlock_button.description = rocket_unlock_button.description.replace("Press to Unlock. ", "")
	select_skill(rocket_unlock_button)
func _on_rocket_upgrade_3_tree_button_pressed() -> void:
	Values.manual_gun_homing = true
	select_skill(rocket_upgrade3_button)
func _on_rocket_upgrade_31_tree_button_pressed() -> void:
	Values.player_manual_gun_speed += 100
	select_skill(rocket_upgrade31_button)
func _on_rocket_upgrade_311_tree_button_pressed() -> void:
	Values.player_manual_gun_speed += 25
	select_skill(rocket_upgrade311_button)
func _on_rocket_upgrade_32_tree_button_pressed() -> void:
	Values.player_manual_aoe_unlocked = true
	select_skill(rocket_upgrade32_button)
func _on_rocket_upgrade_321_tree_button_pressed() -> void:
	Values.player_manual_aoe_area += 10
	select_skill(rocket_upgrade321_button)
func _on_rocket_upgrade_33_tree_button_pressed() -> void:
	Values.player_manual_gun_cooldown = Values.player_manual_gun_cooldown * 0.9
	select_skill(rocket_upgrade33_button)
func _on_rocket_upgrade_34_tree_button_pressed() -> void:
	Values.player_manual_gun_damage = int(floor(Values.player_manual_gun_damage * 1.1))
	select_skill(rocket_upgrade34_button)

func _on_laser_unlock_tree_button_pressed():
	Values.ult_gun_unlocked = true
	laser_unlock_button.description = laser_unlock_button.description.replace("Press to Unlock. ", "")
	select_skill(laser_unlock_button)
func _on_laser_upgrade_1_tree_button_pressed():
	Values.ult_gun_aoe_unlocked = true
	laser_upgrade2_button.lock("Locked")
	select_skill(laser_upgrade1_button)
func _on_laser_upgrade_11_tree_button_pressed() -> void:
	Values.ult_gun_aoe_radius += 10
	select_skill(laser_upgrade11_button)
func _on_laser_upgrade_2_tree_button_pressed() -> void:
	Values.ult_gun_pierce_unlocked = true
	laser_upgrade1_button.lock("Locked")
	select_skill(laser_upgrade2_button)
func _on_laser_upgrade_21_tree_button_pressed() -> void:
	Values.ult_gun_pierce_width += 10
	select_skill(laser_upgrade21_button)
func _on_laser_upgrade_3_tree_button_pressed() -> void:
	Values.player_ult_gun_cooldown = Values.player_ult_gun_cooldown * 0.9
	select_skill(laser_upgrade3_button)
func _on_laser_upgrade_4_tree_button_pressed() -> void:
	Values.player_ult_gun_damage = int(floor(Values.player_ult_gun_damage * 1.1))
	select_skill(laser_upgrade4_button)

func _on_field_unlock_tree_button_pressed() -> void:
	Values.area_field_unlocked = true
	field_unlock_button.description = field_unlock_button.description.replace("Press to Unlock. ", "")
	select_skill(field_unlock_button)
func _on_field_upgrade_1_tree_button_pressed() -> void:
	Values.area_field_range += 25
	select_skill(field_upgrade1_button)
func _on_field_upgrade_11_tree_button_pressed() -> void:
	Values.area_field_2x_enter_unlocked = true
	field_upgrade12_button.lock("Locked")
	field_upgrade13_button.lock("Locked")
	select_skill(field_upgrade11_button)
func _on_field_upgrade_12_tree_button_pressed() -> void:
	Values.area_field_range += 25
	field_upgrade11_button.lock("Locked")
	field_upgrade13_button.lock("Locked")
	select_skill(field_upgrade12_button)
func _on_field_upgrade_13_tree_button_pressed() -> void:
	Values.area_field_4x_exit_unlocked = true
	field_upgrade11_button.lock("Locked")
	field_upgrade12_button.lock("Locked")
	select_skill(field_upgrade13_button)
func _on_field_upgrade_3_tree_button_pressed() -> void:
	Values.area_field_range *= 1.1
	select_skill(field_upgrade3_button)
func _on_field_upgrade_2_tree_button_pressed() -> void:
	Values.area_field_damage = int(floor(Values.area_field_damage * 1.1))
	select_skill(field_upgrade2_button)

func _on_seeker_unlock_tree_button_pressed() -> void:
	Values.seeker_gun_unlocked = true
	seeker_unlock_button.description = seeker_unlock_button.description.replace("Press to Unlock. ", "")
	select_skill(seeker_unlock_button)
func _on_seeker_upgrade_3_tree_button_pressed() -> void:
	Values.seeker_gun_speed *= 1.3
	select_skill(seeker_upgrade3_button)
func _on_seeker_upgrade_313_tree_button_pressed() -> void:
	Values.seeker_gun_damage = int(floor(Values.seeker_gun_damage * 1.1))
	select_skill(seeker_upgrade313_button)
func _on_seeker_upgrade_311_tree_button_pressed() -> void:
	Values.seeker_gun_amount += 1
	select_skill(seeker_upgrade311_button)
func _on_seeker_upgrade_312_tree_button_pressed() -> void:
	Values.seeker_gun_no_return_unlocked = true
	select_skill(seeker_upgrade312_button)
func _on_seeker_upgrade_314_tree_button_pressed() -> void:
	Values.seeker_gun_speed *= 1.1
	select_skill(seeker_upgrade314_button)

func _on_base_damage_pressed() -> void:
	Values.player_melee_gun_damage += 3
	Values.player_manual_gun_damage += 3
	Values.player_ult_gun_damage += 3
	Values.area_field_damage += 3
	Values.seeker_gun_damage += 3
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
func _on_magnet_pressed() -> void:
	Values.pickup_speed += 1
	select_skill(magnet)
func _on_base_speed_pressed() -> void:
	Values.player_max_speed += 2
	select_skill(base_speed)
func _on_base_acceleration_pressed() -> void:
	Values.player_acceleration += 5
	select_skill(base_acceleration)
func _on_shield_regen_pressed() -> void:
	Values.player_hps += 1
	select_skill(shield_regen)
func _on_damage_pressed() -> void:
	Values.player_damage_multiplier += 0.1
	select_skill(damage)
func _on_damage_b_pressed() -> void:
	Values.player_damage_multiplier += 0.2
	select_skill(damage_b)
func _on_damage_al_pressed() -> void:
	Values.player_damage_multiplier += 1.0
	Values.player_max_speed = maxf(25, Values.player_max_speed * 0.75)
	Values.player_acceleration = maxf(25, Values.player_acceleration * 0.75)
	select_skill(damage_al)
func _on_damage_ps_pressed() -> void:
	Values.player_damage_multiplier += 1.0
	Values.projectile_speed_modifier = maxf(0.1, Values.projectile_speed_modifier - 0.25)
	select_skill(damage_ps)
func _on_shields_pressed() -> void:
	Values.player_max_health_multiplier += 0.1
	select_skill(shields)
func _on_magnet_p_pressed() -> void:
	Values.pickup_speed += 5
	select_skill(magnet_p)
func _on_magnet_i_pressed() -> void:
	Values.pickup_speed_instant = true
	select_skill(magnet_i)
func _on_damage_red_pressed() -> void:
	Values.player_damage_reduction += 1
	select_skill(damage_red)
func _on_damage_red_b_pressed() -> void:
	Values.player_damage_reduction += 5
	select_skill(damage_red_b)

func _on_progression_panel_pressed() -> void:
	switch_menu()

func _on_progression_panel_2_pressed() -> void:
	player.item_select.activate()

func switch_menu() -> void:
	if not upgrade_menu.is_visible():
		if get_tree().is_paused():
			return
		upgrade_menu.set_visible(true)
		for slot in get_tree().get_nodes_in_group("Slots"):
			if slot is WeaponSlot and slot.disabled == true:
				if slot.id == Values.weapon_slots:
					slot.set_visible(true)
					if not slot.mouse_entered.is_connected(slot._on_mouse_entered):
						slot.mouse_entered.connect(slot._on_mouse_entered.bind(description))
					if not slot.mouse_exited.is_connected(slot._on_mouse_exited):
						slot.mouse_exited.connect(slot._on_mouse_exited.bind(description))
					if elimination_count[Values.weapon_slots - 1] - Values.eliminations <= 0:
						slot.weapon_tree = weapon_slot.weapon_tree
						slot.weapon_tree_2 = weapon_slot.weapon_tree_2
						slot.weapon_tree_3 = weapon_slot.weapon_tree_3
						slot.weapon_tree_4 = weapon_slot.weapon_tree_4
						slot.weapon_tree_5 = weapon_slot.weapon_tree_5
						if slot.mouse_exited.is_connected(slot._on_mouse_exited):
							slot.mouse_exited.disconnect(slot._on_mouse_exited)
						if slot.mouse_entered.is_connected(slot._on_mouse_entered):
							slot.mouse_entered.disconnect(slot._on_mouse_entered)
						slot.init()
						slot.set_disabled(false)
						Values.weapon_slots += 1
		for button in pricable:
			button.set_process(true)
		if Values.zone == 0:
			repair_button.set_disabled(false)
		else:
			repair_button.set_disabled(true)
		module_label.set_text(str(Values.modules))
		currency_label.set_text(str(snappedf(Values.currency, 0.01)))
		parts_label.set_text(str(Values.parts))
		panel_transitions.set_visible(true)
		get_tree().set_deferred("paused", true)
	else:
		upgrade_menu.set_visible(false)
		panel_transitions.set_visible(false)
		for button in pricable:
			button.set_process(false)
		get_tree().set_deferred("paused", false)

func _on_weapons_tab_pressed() -> void:
	if weapon_display.is_visible():
		return
	weapons_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/selected/33.png"))
	passive_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/unselected/32.png"))
	upgrade_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/unselected/34.png"))
	weapon_display.set_process(true)
	upgrade_display.set_process(false)
	part_display.set_process(false)
	panel_transitions.play("appear")
	await panel_transitions.animation_finished
	upgrade_display.set_visible(false)
	weapon_display.set_visible(true)
	part_display.set_visible(false)
	panel_transitions.play("disappear")
func _on_passive_tab_pressed() -> void:
	if part_display.is_visible():
		return
	weapons_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/unselected/33.png"))
	passive_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/selected/32.png"))
	upgrade_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/unselected/34.png"))
	weapon_display.set_process(false)
	part_display.set_process(true)
	upgrade_display.set_process(false)
	panel_transitions.play("appear")
	await panel_transitions.animation_finished
	part_display.set_visible(true)
	weapon_display.set_visible(false)
	upgrade_display.set_visible(false)
	part_display.check_prices()
	panel_transitions.play("disappear")
func _on_upgrade_tab_pressed() -> void:
	if upgrade_display.is_visible():
		return
	weapons_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/unselected/33.png"))
	passive_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/unselected/32.png"))
	upgrade_tab.set_texture_normal(ResourceLoader.load("res://Assets/icons/selected/34.png"))
	weapon_display.set_process(false)
	upgrade_display.set_process(true)
	part_display.set_process(false)
	panel_transitions.play("appear")
	await panel_transitions.animation_finished
	weapon_display.set_visible(false)
	upgrade_display.set_visible(true)
	part_display.set_visible(false)
	panel_transitions.play("disappear")
