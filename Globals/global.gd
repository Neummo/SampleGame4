extends Node

var low_skill_prices: Array = [10, 20, 50, 100, 250, 500, 1000, 1000, 1000, 1000]
var base_skill_prices: Array = [10, 20, 50, 100, 250, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 11000, 12000, 13000, 15000]
var mid_skill_prices: Array = [1, 1, 1, 1, 1]
var armory_unlock_price: int = 100000
var saved_currency: int = 0
var cant_unpause: bool = false
var energy_modifier_default: float = 1.0
var physical_modifier_default: float = 1.0

var weapons_default: Array = [
	{ 
		"unlocked": func (): return Values.weapon_1_unlocked,
		"icon": "res://Assets/icons/selected/00.png",
		"tree": "../TurretUnlockTreeButton",
		"selected": false,
		"description": "Gattling Gun - Fires energy projectiles towards hostiles",
		"tags": [
			"Energy",
			"Projectile Speed",
			"Rate of Fire",
			"Weapon Range",
		],
	},
	{
		"unlocked": func (): return Values.weapon_2_unlocked,
		"icon": "res://Assets/icons/selected/01.png",
		"tree": "../RocketUnlockTreeButton",
		"selected": false,
		"description": "Rocket Launcher - Fires self-propelled projectiles towards hostiles",
		"tags": [
			"Physical",
			"Projectile Speed",
			"Rate of Fire",
			"Weapon Range",
		],
	},
	{
		"unlocked": func (): return Values.weapon_3_unlocked,
		"icon": "res://Assets/icons/selected/02.png",
		"tree": "../LaserUnlockTreeButton",
		"selected": false,
		"description": "Laser Cannon - Fires concentrated energy beam at light speed",
		"tags": [
			"Energy",
			"Rate of Fire",
			"Weapon Range",
		],
	},
	{
		"unlocked": func (): return Values.weapon_4_unlocked,
		"icon": "res://Assets/icons/selected/03.png",
		"tree": "../SeekerUnlockTreeButton",
		"selected": false,
		"description": "Seeker Drone - Independant drone seeking and ramming hostiles",
		"tags": [
			"Physical",
			"Projectile Speed",
			"Weapon Range",
		],
	},
	{
		"unlocked": func (): return Values.weapon_5_unlocked,
		"icon": "res://Assets/icons/selected/04.png",
		"tree": "../FieldUnlockTreeButton",
		"selected": false,
		"description": "Static Field - Forms a damaging energy field around the ship",
		"tags": [
			"Energy",
		],
	},
]

var item_count: int = 0
var modules: int = 0
var dot_tick_time: float = 1.0
var cluster_leads: Array = []
var minutes_elapsed: int = 0
var currency: float = 0.0
var parts: int = 0
var pickup_speed_instant: bool = false
var pickup_speed: float = 25.0
var part_spawn_chance: float = 0.01
var item_spawn_chance: float = 0.1
var module_spawn_chance: float = 0.05
var neutral_count: int = 0
var enemy_count: int = 0
var eliminations: int = 0
var zone: int = 0
var player_damage_multiplier: float = 1.0
var player_invincible: bool = false
var player_crit_chance: float = 0.01
var player_can_crit: bool = true
var player_crit_damage: float = 2
var player_damage_reduction: int = 0
var player_can_reduce: bool = true
var player_can_mitigate: int = true
var player_mitigate_chance: float = 0
var player_leech_amount: int = 0
var player_max_health: int = 200
var player_hps: int = 0
var player_can_hps: bool = true
var player_can_leech: bool = true
var player_max_health_multiplier: float = 1
var player_range: float = 100.0
var area_field_unlocked: bool = false
var area_field_2x_enter_unlocked: bool = false
var area_field_4x_exit_unlocked: bool = false
var area_field_range: float = 50.0
var area_field_damage: int = 40
var melee_gun_unlocked: bool = false
var melee_gun_homing: bool = false
var turret_calliber_upgrade_unlocked: bool = false
var turret_second_upgrade_unlocked: bool = false
var player_melee_gun_speed: float = 500.0
var player_melee_gun_range: float = 100.0
var player_melee_gun_damage: int = 20
var player_melee_gun_cooldown: float = 1
var manual_gun_unlocked: bool = false
var manual_gun_homing: bool = false
var manual_gun_burst: bool = false
var player_manual_gun_damage: int = 40
var player_manual_gun_cooldown: float = 2
var player_manual_gun_speed: float = 100
var player_manual_aoe_unlocked: bool = false
var player_manual_aoe_area: float = 25.0
var seeker_gun_unlocked: bool = false
var seeker_gun_damage: int = 30
var seeker_gun_speed: float = 300
var seeker_gun_amount: int = 1
var seeker_gun_active_amount: int = 0
var seeker_gun_no_return_unlocked: bool = false
var ult_gun_unlocked: bool = false
var ult_gun_aoe_unlocked: bool = false
var ult_gun_aoe_radius: float = 25.0
var ult_gun_pierce_unlocked: bool = false
var ult_gun_pierce_width: float = 5.0
var player_ult_gun_damage: int = 60
var player_ult_gun_cooldown: float = 3
var player_acceleration: float = 100.0
var player_max_speed: float = 50.0
var player_max_speed_multiplier: float = 1
var player_acceleration_multiplier: float = 1
var enemy_damage: int = 5
var enemy_health: int = 100
var enemy_acceleration: float = 25
var enemy_speed: float = 250.0
var enemy_range: float = 150.0
var enemy_projectile_speed: float = 50.0
var weapon_slots: int = 1
var bounties_unlocked: bool = false
var dash_unlocked: bool = false
var dash_cooldown: float = 10
var dash_str: float = 1000
var lightspeed_unlocked: bool = false
var lightspeed_cooldown: float = 60
var push_str: float = 2.0
var currency_multiplier: float = 1.0
var currency_multiplier_asteroid: float = 1.0
var radar_unlocked: bool = true
var radar_range: float = 650
var attack_speed_modifier: float = 1
var projectile_speed_modifier: float = 1
var player_can_dot: bool = false
var player_dot_percentage: float = 0.1
var energy_modifier: float = energy_modifier_default
var physical_modifier: float = physical_modifier_default



func agility(amount, percentage: bool):
	if percentage:
		player_max_speed_multiplier += amount
		player_acceleration_multiplier += amount
	else:
		player_max_speed += amount
		player_acceleration += amount

func bulk(amount: int, percentage: bool):
	if percentage:
		player_max_health_multiplier += amount
		player_damage_reduction += int(floor(player_damage_reduction / amount))
	else:
		player_max_health += amount
		player_damage_reduction += int(floor(amount / 10))

var weapon_1_unlocked: bool
var weapon_2_unlocked: bool
var weapon_3_unlocked: bool
var weapon_4_unlocked: bool
var weapon_5_unlocked: bool

var weapons: Array = weapons_default

func update_weapon_unlocks(unlocks: Array) -> void:
	var file = FileAccess.open("user://d2.save", FileAccess.WRITE)
	file.store_var(unlocks)
	update_values(unlocks)
	
func get_weapon_unlocks() -> Array:
	var weapon_unlocks = [true, false, false, false, false]
	if FileAccess.file_exists("user://d2.save"):
		var file = FileAccess.open("user://d2.save", FileAccess.READ)
		weapon_unlocks = file.get_var()
	update_values(weapon_unlocks)
	return weapon_unlocks

func update_values(unlocks: Array) -> void:
	Values.weapon_1_unlocked = unlocks[0]
	Values.weapon_2_unlocked = unlocks[1]
	Values.weapon_3_unlocked = unlocks[2]
	Values.weapon_4_unlocked = unlocks[3]
	Values.weapon_5_unlocked = unlocks[4]

func save_d1() -> void:
	var file = FileAccess.open("user://d1.save", FileAccess.WRITE)
	file.store_var(Values.saved_currency)

func load_d1() -> int:
	if FileAccess.file_exists("user://d1.save"):
		var file = FileAccess.open("user://d1.save", FileAccess.READ)
		Values.saved_currency = file.get_var()
		return Values.saved_currency
	return 0

func btify_text(text: String) -> String:
	text = text.replace("Damage", "[color=#f3663f]Damage[/color]")
	text = text.replace("Strength", "[color=#f3663f]Strength[/color]")
	text = text.replace("Critical", "[color=#f3663f]Critical[/color]")
	text = text.replace("Speed", "[color=#42CAFD]Speed[/color]")
	text = text.replace("Acceleration", "[color=#42CAFD]Acceleration[/color]")
	text = text.replace("Rate of Fire", "[color=#7FEFBD]Rate of Fire[/color]")
	text = text.replace("Shield", "[color=#FFC933]Shield[/color]")
	text = text.replace("Regeneration", "[color=#FFC933]Regeneration[/color]")
	text = text.replace("Reduction", "[color=#FFC933]Reduction[/color]")
	text = text.replace("Mitigation", "[color=#FFC933]Mitigation[/color]")
	text = text.replace("Range", "[color=#6a994e]Range[/color]")
	text = text.replace("Weapon Range", "[color=#6a994e]Weapon Range[/color]")
	text = text.replace("Currency", "[color=#6a994e]Currency[/color]")
	
	text = text.replace("Energy", "[color=#42CAFD]Energy[/color]")
	text = text.replace("Physical", "[color=#f3663f]Physical[/color]")
	text = text.replace("Projectile Speed", "[color=#FFC933]Projectile Speed[/color]")
	
	text = text.replace("Gattling Gun", "[color=#42CAFD]Gattling Gun[/color]")
	text = text.replace("Rocket Launcher", "[color=#f3663f]Rocket Launcher[/color]")
	text = text.replace("Laser Cannon", "[color=#42CAFD]Laser Cannon[/color]")
	text = text.replace("Seeker Drone", "[color=#f3663f]Seeker Drone[/color]")
	text = text.replace("Static Field", "[color=#42CAFD]Static Field[/color]")
	
	text = text.replace("-nl", "\n")
	
	return text

func update_saved_currency(value: int) -> void:
	self.load_d1()
	self.saved_currency += value
	self.save_d1()

func init_player_stats() -> void:
	dot_tick_time = 1.0
	minutes_elapsed = 0
	currency = 0.0
	parts = 0
	pickup_speed_instant = false
	pickup_speed = 25.0
	part_spawn_chance = 0.01
	item_spawn_chance = 0.1
	module_spawn_chance = 0.05
	neutral_count = 0
	enemy_count = 0
	zone = 0
	player_damage_multiplier = 1.0
	player_invincible = false
	player_crit_chance = 0.01
	player_damage_reduction = 0
	player_mitigate_chance = 0
	player_leech_amount = 0
	player_max_health = 200
	player_range = 100.0
	area_field_unlocked = false
	area_field_2x_enter_unlocked = false
	area_field_4x_exit_unlocked = false
	area_field_range = 50.0
	area_field_damage = 40
	melee_gun_unlocked = false
	melee_gun_homing = false
	turret_calliber_upgrade_unlocked = false
	turret_second_upgrade_unlocked = false
	player_melee_gun_speed = 1000.0
	player_melee_gun_range = 100.0
	player_melee_gun_damage = 20
	player_melee_gun_cooldown = 1
	manual_gun_unlocked = false
	manual_gun_homing = false
	manual_gun_burst = false
	player_manual_gun_damage = 40
	player_manual_gun_cooldown = 2
	player_manual_gun_speed = 100
	player_manual_aoe_unlocked = false
	player_manual_aoe_area = 25.0
	seeker_gun_unlocked = false
	seeker_gun_damage = 30
	seeker_gun_speed = 300
	seeker_gun_amount = 1
	seeker_gun_active_amount = 0
	seeker_gun_no_return_unlocked = false
	ult_gun_unlocked = false
	ult_gun_aoe_unlocked = false
	ult_gun_aoe_radius = 25.0
	ult_gun_pierce_unlocked = false
	ult_gun_pierce_width = 5.0
	player_ult_gun_damage = 60
	player_ult_gun_cooldown = 3
	player_acceleration = 100.0
	player_max_speed = 50.0
	enemy_damage = 5
	enemy_health = 100
	enemy_acceleration = 25
	enemy_speed = 250
	enemy_range = 150.0
	enemy_projectile_speed = 50.0
	weapon_slots = 1
	bounties_unlocked = false
	dash_unlocked = false
	dash_cooldown = 10
	eliminations = 0
	dash_str = 5000
	lightspeed_unlocked = false
	lightspeed_cooldown = 60
	push_str = 2.0
	currency_multiplier = 1.0
	currency_multiplier_asteroid = 1.0
	radar_unlocked = true
	radar_range = 650
	attack_speed_modifier = 1
	projectile_speed_modifier = 1
	player_crit_damage = 2
	player_can_crit = true
	player_can_dot = false
	player_dot_percentage = 0.1
	player_max_health_multiplier = 1
	player_max_speed_multiplier = 1
	player_acceleration_multiplier = 1
	player_can_reduce = true
	player_can_mitigate = true
	player_hps = 0
	player_can_hps = true
	player_can_leech = true
	item_count = 0
	modules = 0
	cluster_leads = []
	weapons = weapons_default
	energy_modifier = energy_modifier_default
	physical_modifier = physical_modifier_default

func display_number(val, prefix: String, pos: Vector2, color: String, parent: Node2D = null, is_critical: bool = false) -> bool:
	var number = Label.new()
	number.global_position = Vector2(pos.x + randi_range(-5, 5), pos.y)
	number.text = prefix + str(val)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var col = color
	if is_critical:
		col = "#B22"
	
	number.label_settings.font_color = col
	number.label_settings.font_size = 7
	number.label_settings.outline_color = "#000000"
	number.label_settings.outline_size = 3
	
	var display_motion: Vector2
	if parent == null:
		display_motion = Vector2(5, 5)
		if randi_range(0, 1) == 0:
			display_motion.x *= -1
		if randi_range(0, 1) == 0:
			display_motion.y *= -1
		call_deferred("add_child", number)
	else:
		display_motion = Vector2(0, -5)
		parent.call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position", number.position + display_motion, 0.75
	)
	#tween.tween_property(
	#	number, "position:y", number.position.y, 0.5
	#).set_ease(Tween.EASE_IN).set_delay(0.25)
	#tween.tween_property(
	#	number, "scale", Vector2.ZERO, 0.25
	#).set_ease(Tween.EASE_IN).set_delay(0.5)
	await tween.finished
	if is_instance_valid(number):
		number.call_deferred("queue_free")
	return true
