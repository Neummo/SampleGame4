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
					"title": "[center][color=#6a994e]Shield[/color][/center]",
					"description": "Shield +50",
					"icon": "res://Assets/icons/selected/25.png",
					"effect": func effect() -> void: Values.player_max_health += 50,
					"max": -1,
					"hits": 0
				},
				"1": {
					"id": 1,
					"title": "[center][color=#6a994e]Plate[/color][/center]",
					"description": "Damage Reduction +2",
					"icon": "res://Assets/icons/selected/27.png",
					"effect": func effect() -> void: Values.player_damage_reduction += 2,
					"max": -1,
					"hits": 0
				},
				"2": {
					"id": 2,
					"title": "[center][color=#6a994e]Engine[/color][/center]",
					"description": "Max Speed +5",
					"icon": "res://Assets/icons/selected/09.png",
					"effect": func effect() -> void: Values.player_max_speed += 5,
					"max": 50,
					"hits": 0
				},
				"3": {
					"id": 3,
					"title": "[center][color=#6a994e]High Grade Fuel[/color][/center]",
					"description": "Acceleration +10",
					"icon": "res://Assets/icons/selected/08.png",
					"effect": func effect() -> void: Values.player_acceleration += 10,
					"max": 50,
					"hits": 0
				},
				"4": {
					"id": 4,
					"title": "[center][color=#6a994e]Communicator[/color][/center]",
					"description": "Weapon Range +5",
					"icon": "res://Assets/icons/selected/15.png",
					"effect": func effect() -> void: Values.player_range += 5,
					"max": 50,
					"hits": 0
				},
				"5": {
					"id": 5,
					"title": "[center][color=#6a994e]Energy Redirection[/color][/center]",
					"description": "Damage +10%",
					"icon": "res://Assets/icons/selected/06.png",
					"effect": func effect() -> void: Values.player_damage_multiplier += 0.1,
					"max": -1,
					"hits": 0
				},
				"6": {
					"id": 17,
					"title": "[center][color=#6a994e]Coolant[/color][/center]",
					"description": "Rate of Fire +10%",
					"icon": "res://Assets/icons/selected/07.png",
					"effect": func effect() -> void: Values.attack_speed_modifier += 0.1,
					"max": -1,
					"hits": 0
				},
				"7": {
					"id": 19,
					"title": "[center][color=#6a994e]Potential Energy[/color][/center]",
					"description": "Projectile Speed +10%",
					"icon": "res://Assets/icons/selected/14.png",
					"effect": func effect() -> void: Values.projectile_speed_modifier += 0.1,
					"max": -1,
					"hits": 0
				},
				"8": {
					"id": 21,
					"title": "[center][color=#6a994e]Economy 101[/color][/center]",
					"description": "Currency Value +5%",
					"icon": "res://Assets/icons/selected/29.png",
					"effect": func effect() -> void: Values.currency_multiplier += 0.05,
					"max": -1,
					"hits": 0
				},
				"9": {
					"id": 22,
					"title": "[center][color=#6a994e]Magnet Maintenance[/color][/center]",
					"description": "Magnet Strength +5",
					"icon": "res://Assets/icons/selected/20.png",
					"effect": func effect() -> void: Values.pickup_speed += 5,
					"max": 100,
					"hits": 0
				},
			}
		},
		"1": {
			"data": {
				"0": {
					"id": 6,
					"title": "[center][color=#3299ea]Critical Precision[/color][/center]",
					"description": "Critical hit Chance +2%",
					"icon": "res://Assets/icons/selected/21.png",
					"effect": func effect() -> void: Values.player_crit_chance += 0.02,
					"max": 42,
					"hits": 0
				},
				"1": {
					"id": 7,
					"title": "[center][color=#3299ea]Magnet[/color][/center]",
					"description": "Magnet Strength +25\nSpeed -5",
					"icon": "res://Assets/icons/selected/20.png",
					"effect": func effect() -> void:
						Values.pickup_speed += 25
						Values.player_max_speed = maxi(25, Values.player_max_speed - 5),
					"max": 100,
					"hits": 0
				},
				"2": {
					"id": 8,
					"title": "[center][color=#3299ea]Light Build[/color][/center]",
					"description": "Speed & Acceleration +10",
					"icon": "res://Assets/icons/selected/10.png",
					"effect": func effect() -> void: Values.agility(10, false),
					"max": 25,
					"hits": 0
					
				},
				"3": {
					"id": 9,
					"title": "[center][color=#3299ea]Generator[/color][/center]",
					"description": "Shield +50 & Damage Reduction +5\nSpeed -5",
					"icon": "res://Assets/icons/selected/26.png",
					"effect": func effect() -> void:
						Values.bulk(50, false)
						Values.player_max_speed = maxi(25, Values.player_max_speed - 5),
					"max": -1,
					"hits": 0
				},
				"4": {
					"id": 18,
					"title": "[center][color=#3299ea]Critical Mass[/color][/center]",
					"description": "Critical hit Damage +20%",
					"icon": "res://Assets/icons/selected/22.png",
					"effect": func effect() -> void: Values.player_crit_damage += 0.2,
					"max": -1,
					"hits": 0
				},
				"5": {
					"id": 20,
					"title": "[center][color=#3299ea]Economy 102[/color][/center]",
					"description": "Currency Value +10%",
					"icon": "res://Assets/icons/selected/29.png",
					"effect": func effect() -> void: Values.currency_multiplier += 0.1,
					"max": -1,
					"hits": 0
				},
				"6": {
					"id": 23,
					"title": "[center][color=#3299ea]Radar Extension[/color][/center]",
					"description": "Asteroid Radar Range +10",
					"icon": "res://Assets/icons/selected/23.png",
					"effect": func effect() -> void: Values.radar_range += 10.0,
					"max": -1,
					"hits": 0
				},
				"7": {
					"id": 24,
					"title": "[center][color=#3299ea]Energy Coil[/color][/center]",
					"description": "Energy Damage +10%",
					"icon": "res://Assets/icons/selected/10.png",
					"effect": func effect() -> void: Values.energy_modifier += 0.1,
					"max": -1,
					"hits": 0
				},
				"8": {
					"id": 25,
					"title": "[center][color=#3299ea]Ol' Gunpowder[/color][/center]",
					"description": "Physical Damage +10%",
					"icon": "res://Assets/icons/selected/21.png",
					"effect": func effect() -> void: Values.physical_modifier += 0.1,
					"max": -1,
					"hits": 0
				},
				"9": {
					"id": 28,
					"title": "[center][color=#3299ea]Bulk Up[/color][/center]",
					"description": "Rate of Fire +25%\nSpeed & Acceleration -5",
					"icon": "res://Assets/icons/selected/07.png",
					"effect": func effect() -> void:
						Values.attack_speed_modifier += 0.25
						Values.player_max_speed = maxi(25, Values.player_max_speed - 5)
						Values.player_acceleration = maxi(25, Values.player_acceleration - 5),
					"max": 25,
					"hits": 0
				},
			}
		},
		"2": {
			"data": {
				"0": {
					"id": 10,
					"title": "[center][color=#ffca3a]Absorbtion Reactor[/color][/center]",
					"description": "Damage Mitigation Chance +2%",
					"icon": "res://Assets/icons/selected/28.png",
					"effect": func effect() -> void: Values.player_mitigate_chance += 0.02,
					"max": 20,
					"hits": 0
				},
				"1": {
					"id": 11,
					"title": "[center][color=#ffca3a]Energy Leech Beam[/color][/center]",
					"description": "Eliminations recharge Shield +1",
					"icon": "res://Assets/icons/selected/35.png",
					"effect": func effect() -> void: Values.player_leech_amount += 1,
					"max": -1,
					"hits": 0
				},
				"2": {
					"id": 12,
					"title": "[center][color=#ffca3a]Mining Enthusiast[/color][/center]",
					"description": "Asteroid Value +50%",
					"icon": "res://Assets/icons/selected/29.png",
					"effect": func effect() -> void: Values.currency_multiplier_asteroid += 0.5,
					"max": -1,
					"hits": 0
				},
				"3": {
					"id": 13,
					"title": "[center][color=#ffca3a]Energy Condensator[/color][/center]",
					"description": "Shield +30%",
					"icon": "res://Assets/icons/selected/26.png",
					"effect": func effect() -> void: Values.player_max_health_multiplier += 0.3,
					"max": 10,
					"hits": 0
				},
				"4": {
					"id": 14,
					"title": "[center][color=#ffca3a]Custom Build[/color][/center]",
					"description": "Speed & Acceleration +10%",
					"icon": "res://Assets/icons/selected/10.png",
					"effect": func effect() -> void: Values.agility(0.1, true),
					"max": 10,
					"hits": 0
				},
				"5": {
					"id": 15,
					"title": "[center][color=#ffca3a]Economy 103[/color][/center]",
					"description": "Currency Value +20%",
					"icon": "res://Assets/icons/selected/29.png",
					"effect": func effect() -> void: Values.currency_multiplier += 0.2,
					"max": -1,
					"hits": 0
				},
				"6": {
					"id": 16,
					"title": "[center][color=#ffca3a]Repair Bay[/color][/center]",
					"description": "Shield Regeneration per second +1",
					"icon": "res://Assets/icons/selected/36.png",
					"effect": func effect() -> void: Values.player_hps += 1,
					"max": 100,
					"hits": 0
				},
				"7": {
					"id": 26,
					"title": "[center][color=#ffca3a]Energy Redirection[/color][/center]",
					"description": "Energy Damage +50%\nPhysical Damage -25%",
					"icon": "res://Assets/icons/selected/10.png",
					"effect": func effect() -> void: 
						Values.energy_modifier += 0.5
						Values.physical_modifier -= 0.25,
					"max": -1,
					"hits": 0
				},
				"8": {
					"id": 27,
					"title": "[center][color=#ffca3a]Big Boom[/color][/center]",
					"description": "nPhysical Damage +50%\nEnergy Damage -25%",
					"icon": "res://Assets/icons/selected/21.png",
					"effect": func effect() -> void:
						Values.physical_modifier += 0.5
						Values.energy_modifier -= 0.25,
					"max": -1,
					"hits": 0
				},
				"9": {
					"id": 29,
					"title": "[center][color=#ffca3a]Tank[/color][/center]",
					"description": "Physical & Energy Damage -25%\nShield +50%",
					"icon": "res://Assets/icons/selected/26.png",
					"effect": func effect() -> void:
						Values.physical_modifier -= 0.25
						Values.energy_modifier -= 0.25
						Values.player_max_health_multiplier += 0.5,
					"max": -1,
					"hits": 0
				},
				"10": {
					"id": 30,
					"title": "[center][color=#ffca3a]Nimble[/color][/center]",
					"description": "Physical & Energy Damage +25%\nShield -25%",
					"icon": "res://Assets/icons/selected/24.png",
					"effect": func effect() -> void:
						Values.physical_modifier += 0.25
						Values.energy_modifier += 0.25
						Values.player_max_health_multiplier -= 0.25,
					"max": -1,
					"hits": 0
				},
			}
		}
}
