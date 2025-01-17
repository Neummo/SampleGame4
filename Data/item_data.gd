extends Node

var item_data: Dictionary = {}

func _ready():
	item_data = load_data()

func load_data() -> Dictionary:
	return {
		"0": {
			"data": {
				"0": {
					"id": 0,
					"title": "Shield",
					"description": "Increases Shields +50",
					"icon": "res://Assets/aaa.png",
					"effect": func effect() -> void: Values.player_max_health += 50,
					"max": -1,
					"hits": 0
				},
				"1": {
					"id": 1,
					"title": "Plate",
					"description": "Increases Damage Reduction +1",
					"icon": "res://Assets/aaa.png",
					"effect": func effect() -> void: Values.player_damage_reduction += 1,
					"max": -1,
					"hits": 0
				},
				"2": {
					"id": 2,
					"title": "Engine",
					"description": "Increases Max Speed +20",
					"icon": "res://Assets/aaa.png",
					"effect": func effect() -> void: Values.player_max_speed += 20,
					"max": 50,
					"hits": 0
				},
				"3": {
					"id": 3,
					"title": "High Grade Fuel",
					"description": "Increases Acceleration +20",
					"icon": "res://Assets/aaa.png",
					"effect": func effect() -> void: Values.player_acceleration += 20,
					"max": 50,
					"hits": 0
				},
				"4": {
					"id": 4,
					"title": "Communicator",
					"description": "Increases Weapon Range +20",
					"icon": "res://Assets/aaa.png",
					"effect": func effect() -> void: Values.player_range += 20,
					"max": 50,
					"hits": 0
				},
				"5": {
					"id": 5,
					"title": "Energy Redirection",
					"description": "Increases Damage +10%",
					"icon": "res://Assets/aaa.png",
					"effect": func effect() -> void: Values.player_damage_multiplier += 0.1,
					"max": -1,
					"hits": 0
				},
				"6": {
					"id": 17,
					"title": "Coolant",
					"description": "Increases Rate of Fire +10%",
					"icon": "res://Assets/aaa.png",
					"effect": func effect() -> void: Values.attack_speed_modifier += 0.1,
					"max": -1,
					"hits": 0
				},
				"7": {
					"id": 19,
					"title": "Potential Energy",
					"description": "Increases Projectile Speed +20%",
					"icon": "res://Assets/aaa.png",
					"effect": func effect() -> void: Values.projectile_speed_modifier += 0.2,
					"max": -1,
					"hits": 0
				},
				"8": {
					"id": 21,
					"title": "Economy 101",
					"description": "Increases Currency Value +5%",
					"icon": "res://Assets/aaa.png",
					"effect": func effect() -> void: Values.currency_multiplier += 0.05,
					"max": -1,
					"hits": 0
				},
				"9": {
					"id": 22,
					"title": "Magnet Maintenance",
					"description": "Increases Magnet Strengh +20",
					"icon": "res://Assets/aaa.png",
					"effect": func effect() -> void: Values.pickup_speed += 20,
					"max": 100,
					"hits": 0
				},
			}
		},
		"1": {
			"data": {
				"0": {
					"id": 6,
					"title": "Critical Precision",
					"description": "Increased Critical hit Chance +2%",
					"icon": "res://Assets/kate2.png",
					"effect": func effect() -> void: Values.player_crit_chance += 0.02,
					"max": 42,
					"hits": 0
				},
				"1": {
					"id": 7,
					"title": "Magnet",
					"description": "Increases Magnet Strengh +50",
					"icon": "res://Assets/kate2.png",
					"effect": func effect() -> void: Values.pickup_speed += 50,
					"max": 100,
					"hits": 0
				},
				"2": {
					"id": 8,
					"title": "Light Build",
					"description": "Increases Speed and Acceleration +20",
					"icon": "res://Assets/kate2.png",
					"effect": func effect() -> void: Values.agility(20, false),
					"max": 25,
					"hits": 0
					
				},
				"3": {
					"id": 9,
					"title": "Generator",
					"description": "Increases Shields +50 and Damage Reduction +5",
					"icon": "res://Assets/kate2.png",
					"effect": func effect() -> void: Values.bulk(50, false),
					"max": -1,
					"hits": 0
				},
				"4": {
					"id": 18,
					"title": "Critical Mass",
					"description": "Increased Critical hit Damage +20%",
					"icon": "res://Assets/kate2.png",
					"effect": func effect() -> void: Values.player_crit_damage += 0.2,
					"max": -1,
					"hits": 0
				},
				"5": {
					"id": 20,
					"title": "Economy 102",
					"description": "Increases Currency Value +10%",
					"icon": "res://Assets/kate2.png",
					"effect": func effect() -> void: Values.currency_multiplier += 0.1,
					"max": -1,
					"hits": 0
				},
			}
		},
		"2": {
			"data": {
				"0": {
					"id": 10,
					"title": "Absorbtion Reactor",
					"description": "Increases Damage Mitigation Chance +2%",
					"icon": "res://Assets/kate3.png",
					"effect": func effect() -> void: Values.player_mitigate_chance += 0.02,
					"max": 20,
					"hits": 0
				},
				"1": {
					"id": 11,
					"title": "Energy Leech Beam",
					"description": "Eliminations recharge Shields +1",
					"icon": "res://Assets/kate3.png",
					"effect": func effect() -> void: Values.player_leech_amount += 1,
					"max": -1,
					"hits": 0
				},
				"2": {
					"id": 12,
					"title": "Mining Enthusiast",
					"description": "Increases Asteroid Value +50%",
					"icon": "res://Assets/kate3.png",
					"effect": func effect() -> void: Values.currency_multiplier_asteroid += 0.5,
					"max": -1,
					"hits": 0
				},
				"3": {
					"id": 13,
					"title": "Energy Condensator",
					"description": "Percentage Shields increase +30%",
					"icon": "res://Assets/kate3.png",
					"effect": func effect() -> void: Values.player_max_health_multiplier += 0.3,
					"max": 10,
					"hits": 0
				},
				"4": {
					"id": 14,
					"title": "Custom Build",
					"description": "Percentage Speed and Acceleration increase +10%",
					"icon": "res://Assets/kate3.png",
					"effect": func effect() -> void: Values.agility(0.1, true),
					"max": 10,
					"hits": 0
				},
				"5": {
					"id": 15,
					"title": "Economy 103",
					"description": "Increases Currency Value +20%",
					"icon": "res://Assets/kate3.png",
					"effect": func effect() -> void: Values.currency_multiplier += 0.2,
					"max": -1,
					"hits": 0
				},
				"6": {
					"id": 16,
					"title": "Repair Bay",
					"description": "Increases Shield Regeneration per second +1",
					"icon": "res://Assets/kate3.png",
					"effect": func effect() -> void: Values.player_hps += 1,
					"max": 100,
					"hits": 0
				},
			}
		}
}
