extends Control

@export var first_node: PartUpgradeButton

@export var first_tree: PartUpgradeButton
@export var ft1: PartUpgradeButton
@export var ft2: PartUpgradeButton
@export var ft3: PartUpgradeButton
@export var ft9: PartUpgradeButton
@export var ft10: PartUpgradeButton
@export var ft11: PartUpgradeButton
@export var ft12: PartUpgradeButton
@export var ft13: PartUpgradeButton
@export var ft14: PartUpgradeButton
@export var ft15: PartUpgradeButton
@export var ft16: PartUpgradeButton
@export var ft17: PartUpgradeButton
@export var ft18: PartUpgradeButton
@export var ft19: PartUpgradeButton
@export var ft20: PartUpgradeButton
@export var ft21: PartUpgradeButton
@export var ft22: PartUpgradeButton
@export var ft23: PartUpgradeButton
@export var ft24: PartUpgradeButton
@export var ft25: PartUpgradeButton
@export var ft26: PartUpgradeButton
@export var ft27: PartUpgradeButton

@export var second_tree: PartUpgradeButton
@export var st1: PartUpgradeButton
@export var st2: PartUpgradeButton
@export var st3: PartUpgradeButton
@export var st9: PartUpgradeButton
@export var st10: PartUpgradeButton
@export var st11: PartUpgradeButton
@export var st12: PartUpgradeButton
@export var st13: PartUpgradeButton
@export var st14: PartUpgradeButton
@export var st15: PartUpgradeButton
@export var st16: PartUpgradeButton
@export var st17: PartUpgradeButton
@export var st18: PartUpgradeButton
@export var st19: PartUpgradeButton
@export var st20: PartUpgradeButton
@export var st21: PartUpgradeButton
@export var st22: PartUpgradeButton
@export var st23: PartUpgradeButton
@export var st24: PartUpgradeButton
@export var st25: PartUpgradeButton
@export var st26: PartUpgradeButton
@export var st27: PartUpgradeButton

@export var third_tree: PartUpgradeButton
@export var tt1: PartUpgradeButton
@export var tt2: PartUpgradeButton
@export var tt3: PartUpgradeButton
@export var tt9: PartUpgradeButton
@export var tt10: PartUpgradeButton
@export var tt11: PartUpgradeButton
@export var tt12: PartUpgradeButton
@export var tt13: PartUpgradeButton
@export var tt14: PartUpgradeButton
@export var tt15: PartUpgradeButton
@export var tt16: PartUpgradeButton
@export var tt17: PartUpgradeButton
@export var tt18: PartUpgradeButton
@export var tt19: PartUpgradeButton
@export var tt20: PartUpgradeButton
@export var tt21: PartUpgradeButton
@export var tt22: PartUpgradeButton
@export var tt23: PartUpgradeButton
@export var tt24: PartUpgradeButton
@export var tt25: PartUpgradeButton
@export var tt26: PartUpgradeButton
@export var tt27: PartUpgradeButton

@export var fourth_tree: PartUpgradeButton
@export var ht1: PartUpgradeButton
@export var ht2: PartUpgradeButton
@export var ht3: PartUpgradeButton
@export var ht9: PartUpgradeButton
@export var ht10: PartUpgradeButton
@export var ht11: PartUpgradeButton
@export var ht12: PartUpgradeButton
@export var ht13: PartUpgradeButton
@export var ht14: PartUpgradeButton
@export var ht15: PartUpgradeButton
@export var ht16: PartUpgradeButton
@export var ht17: PartUpgradeButton
@export var ht18: PartUpgradeButton
@export var ht19: PartUpgradeButton
@export var ht20: PartUpgradeButton
@export var ht21: PartUpgradeButton
@export var ht22: PartUpgradeButton
@export var ht23: PartUpgradeButton
@export var ht24: PartUpgradeButton
@export var ht25: PartUpgradeButton
@export var ht26: PartUpgradeButton
@export var ht27: PartUpgradeButton

func _ready() -> void:
	first_node.description = "- Unlocks Bounties"
	first_node.effect = func (): 
		Values.bounties_unlocked = true
		get_tree().get_first_node_in_group("BountyButton").check_price()
	
	first_tree.description = "- Increases Acceleration +10%"
	first_tree.effect = func (): Values.player_acceleration_multiplier += 0.1
	ft1.description = "- Increases Speed +5%"
	ft1.effect = func (): Values.player_max_speed_multiplier += 0.05
	ft2.description = "- Increases Acceleration +10%-nl- Increases Speed +5%"
	ft2.effect = func (): 
		Values.player_max_speed_multiplier += 0.05
		Values.player_acceleration_multiplier += 0.1
	ft3.description = "- Unlocks Hyper Speed"
	ft3.effect = func (): Values.lightspeed_unlocked = true
	ft9.description = "- Decreases Hyper Speed Cooldown -5s"
	ft9.effect = func (): Values.lightspeed_cooldown -= 5
	ft10.description = "- Decreases Hyper Speed Cooldown -5s"
	ft10.effect = func (): Values.lightspeed_cooldown -= 5
	ft11.description = "- Decreases Hyper Speed Cooldown -5s"
	ft11.effect = func (): Values.lightspeed_cooldown -= 5
	ft12.description = "- Decreases Hyper Speed Cooldown -10s"
	ft12.effect = func (): Values.lightspeed_cooldown -= 10
	ft13.description = "- Increases Asteroid Radar Range +100"
	ft13.effect = func (): Values.radar_range += 100
	ft14.description = "- Increases Asteroid Radar Range +100"
	ft14.effect = func ():Values.radar_range += 100
	ft15.description = "- Increases Asteroid Radar Range +100"
	ft15.effect = func (): Values.radar_range += 100
	ft16.description = "- Increases Asteroid Radar Range +200"
	ft16.effect = func (): Values.radar_range += 200
	ft17.description = "- Increases Acceleration +10%"
	ft17.effect = func (): Values.player_acceleration_multiplier += 0.1
	ft18.description = "- Increases Speed +5%"
	ft18.effect = func (): Values.player_max_speed_multiplier += 0.05
	ft19.description = "- Increases Speed +5%"
	ft19.effect = func (): Values.player_max_speed_multiplier += 0.05
	ft20.description = "- Increases Speed +5%"
	ft20.effect = func (): Values.player_max_speed_multiplier += 0.05
	ft21.description = "- Increases Speed +10%"
	ft21.effect = func (): Values.player_max_speed_multiplier += 0.1
	ft22.description = "- Increases Acceleration +10%"
	ft22.effect = func (): Values.player_acceleration_multiplier += 0.1
	ft23.description = "- Increases Acceleration +10%"
	ft23.effect = func (): Values.player_acceleration_multiplier += 0.1
	ft24.description = "- Increases Acceleration +20%"
	ft24.effect = func (): Values.player_acceleration_multiplier += 0.2
	ft25.description = "- Increases Damage Mitigation Chance +5%"
	ft25.effect = func (): Values.player_mitigate_chance += 0.05
	ft26.description = "- Increases Damage Mitigation Chance +5%"
	ft26.effect = func (): Values.player_mitigate_chance += 0.05
	ft27.description = "- Increases Damage Mitigation Chance +10%"
	ft27.effect = func (): Values.player_mitigate_chance += 0.1
	
	second_tree.description = "- Increases Magnet Strength +50"
	second_tree.effect = func (): Values.pickup_speed += 50
	st1.description = "- Increases Weapon Range +50"
	st1.effect = func (): Values.player_range += 50
	st2.description = "- Increases Magnet Strength +50-nl- Increases Weapon Range +50"
	st2.effect = func ():
		Values.pickup_speed += 50
		Values.player_range += 50
	st3.description = "- Increases Currency gained +10%"
	st3.effect = func (): Values.currency_multiplier += 0.1
	st9.description = "- Increases Currency gained +5%"
	st9.effect = func (): Values.currency_multiplier += 0.05
	st10.description = "- Increases Currency gained +5%"
	st10.effect = func (): Values.currency_multiplier += 0.05
	st11.description = "- Increases Currency gained +5%"
	st11.effect = func (): Values.currency_multiplier += 0.05
	st12.description = "- Increases Currency gained +15%"
	st12.effect = func (): Values.currency_multiplier += 0.15
	st13.description = "- Increases Asteroid Currency Value +10%"
	st13.effect = func (): Values.currency_multiplier_asteroid += 0.1
	st14.description = "- Increases Asteroid Currency Value +10%"
	st14.effect = func (): Values.currency_multiplier_asteroid += 0.1
	st15.description = "- Increases Asteroid Currency Value +10%"
	st15.effect = func (): Values.currency_multiplier_asteroid += 0.1
	st16.description = "- Increases Asteroid Currency Value +70%"
	st16.effect = func (): Values.currency_multiplier_asteroid += 0.7
	st17.description = "- Increases Magnet Strength +20"
	st17.effect = func (): Values.pickup_speed += 20
	st18.description = "- Increases Weapon Range +20"
	st18.effect = func (): Values.player_range += 20
	st19.description = "- Increases Magnet Strength +20"
	st19.effect = func (): Values.pickup_speed += 20
	st20.description = "- Increases Magnet Strength +20"
	st20.effect = func (): Values.pickup_speed += 20
	st21.description = "- Increases Magnet Strength +20"
	st21.effect = func (): Values.pickup_speed += 50
	st22.description = "- Increases Weapon Range +20"
	st22.effect = func (): Values.player_range += 20
	st23.description = "- Increases Weapon Range +20"
	st23.effect = func (): Values.player_range += 20
	st24.description = "- Increases Weapon Range +50"
	st24.effect = func (): Values.player_range += 50
	st25.description = "- Reduces Damage over Time tick time -10%"
	st25.effect = func (): Values.dot_tick_time -= 0.1
	st26.description = "- Reduces Damage over Time tick time -10%"
	st26.effect = func (): Values.dot_tick_time -= 0.1
	st27.description = "- Reduces Damage over Time tick time -30%"
	st27.effect = func (): Values.dot_tick_time -= 0.3
	
	third_tree.description = "- Increases Damage +10%"
	third_tree.effect = func (): Values.player_damage_multiplier += 0.1
	tt1.description = "- Increases Rate of Fire +10%"
	tt1.effect = func (): Values.attack_speed_modifier += 0.1
	tt2.description = "- Increases Damage +10%-nl- Increases Rate of Fire 10%"
	tt2.effect = func ():
		Values.player_damage_multiplier += 0.1
		Values.attack_speed_modifier += 0.1
	tt3.description = "- Increases Critical hit Chance +2%-nl- Increases Critical hit Damage +20%"
	tt3.effect = func ():
		Values.player_crit_chance += 0.02
		Values.player_crit_damage += 0.2
	tt9.description = "- Increases Critical hit Damage +10%"
	tt9.effect = func (): Values.player_crit_damage += 0.1
	tt10.description = "- Increases Critical hit Damage +10%"
	tt10.effect = func (): Values.player_crit_damage += 0.1
	tt11.description = "- Increases Critical hit Damage +10%"
	tt11.effect = func (): Values.player_crit_damage += 0.1
	tt12.description = "- Increases Critical hit Damage +50%"
	tt12.effect = func (): Values.player_crit_damage += 0.5
	tt13.description = "- Increases Critical hit Chance +1%"
	tt13.effect = func (): Values.player_crit_chance += 0.01
	tt14.description = "- Increases Critical hit Chance +1%"
	tt14.effect = func (): Values.player_crit_chance += 0.01
	tt15.description = "- Increases Critical hit Chance +1%"
	tt15.effect = func (): Values.player_crit_chance += 0.01
	tt16.description = "- Increases Critical hit Chance +10%"
	tt16.effect = func (): Values.player_crit_chance += 0.1
	tt17.description = "- Increases Damage +10%"
	tt17.effect = func (): Values.player_damage_multiplier += 0.1
	tt18.description = "- Increases Rate of Fire +10%"
	tt18.effect = func (): Values.attack_speed_modifier += 0.1
	tt19.description = "- Increases Damage +10%"
	tt19.effect = func (): Values.player_damage_multiplier += 0.1
	tt20.description = "- Increases Damage +10%"
	tt20.effect = func (): Values.player_damage_multiplier += 0.1
	tt21.description = "- Increases Damage +25%"
	tt21.effect = func (): Values.player_damage_multiplier += 0.25
	tt22.description = "- Increases Rate of Fire +10%"
	tt22.effect = func (): Values.attack_speed_modifier += 0.1
	tt23.description = "- Increases Rate of Fire +10%"
	tt23.effect = func (): Values.attack_speed_modifier += 0.1
	tt24.description = "- Increases Rate of Fire +25%"
	tt24.effect = func (): Values.attack_speed_modifier += 0.25
	tt25.description = "- Deal and additional 10% of Damage Dealt over 10 seconds"
	tt25.effect = func (): Values.player_can_dot = true
	tt26.description = "- Increases Damage over Time +20% of damage dealt"
	tt26.effect = func (): Values.player_dot_percentage += 0.2
	tt27.description = "- Increases Damage over Time +20% of damage dealt"
	tt27.effect = func ():Values.player_dot_percentage += 0.2
	
	fourth_tree.description = "- Increases Shields +50"
	fourth_tree.effect = func (): Values.player_max_health += 50
	ht1.description = "- Increases Shields +50"
	ht1.effect = func (): Values.player_max_health += 50
	ht2.description = "- Increases Shields +5%"
	ht2.effect = func (): Values.player_max_health_multiplier += 0.05
	ht3.description = "- Increases Damage Reduction +1-nl- Increases Damage Mitigation Chance +5%"
	ht3.effect = func ():
		Values.player_damage_reduction += 1
		Values.player_mitigate_chance += 0.05
	ht9.description = "- Increases Damage Mitigation Chance +5%"
	ht9.effect = func (): Values.player_mitigate_chance += 0.05
	ht10.description = "- Increases Damage Mitigation Chance +5%"
	ht10.effect = func (): Values.player_mitigate_chance += 0.05
	ht11.description = "- Increases Damage Mitigation Chance +5%"
	ht11.effect = func (): Values.player_mitigate_chance += 0.05
	ht12.description = "- Increases Damage Mitigation Chance +10%"
	ht12.effect = func (): Values.player_mitigate_chance += 0.1
	ht13.description = "- Increases Damage Reduction +1"
	ht13.effect = func (): Values.player_damage_reduction += 1
	ht14.description = "- Increases Damage Reduction +1"
	ht14.effect = func (): Values.player_damage_reduction += 1
	ht15.description = "- Increases Damage Reduction +1"
	ht15.effect = func (): Values.player_damage_reduction += 1
	ht16.description = "- Increases Damage Reduction +5"
	ht16.effect = func (): Values.player_damage_reduction += 5
	ht17.description = "- Increases Shields +50"
	ht17.effect = func (): Values.player_max_health += 50
	ht18.description = "- Increases Shields +10%"
	ht18.effect = func (): Values.player_max_health_multiplier += 0.1
	ht19.description = "- Increases Shield Regeneration +2/s"
	ht19.effect = func (): Values.player_hps += 2
	ht20.description = "- Increases Shield Regeneration +3/s"
	ht20.effect = func (): Values.player_hps += 3
	ht21.description = "- Increases Shield Regeneration +5/s"
	ht21.effect = func (): Values.player_hps += 5
	ht22.description = "- Increases Shield Recharge from destroyed Enemies +1"
	ht22.effect = func (): Values.player_leech_amount += 1
	ht23.description = "- Increases Shield Recharge from destroyed Enemies +1"
	ht23.effect = func (): Values.player_leech_amount += 1
	ht24.description = "- Increases Shield Recharge from destroyed Enemies +3"
	ht24.effect = func (): Values.player_leech_amount += 3
	ht25.description = "- Decreases Impact Strength when Hit -20%"
	ht25.effect = func (): Values.push_str -= 0.2
	ht26.description = "- Decreases Impact Strength when Hit -30%"
	ht26.effect = func (): Values.push_str -= 0.3
	ht27.description = "- Prevents Impact when Hit"
	ht27.effect = func (): Values.push_str = 1
	
func check_prices() -> void:
	var nodes = get_all_children(first_node)
	for node in nodes:
		if node is PartUpgradeButton:
			node.check_price()
	
func get_all_children(node, array: Array = []) -> Array:
	array.push_back(node)
	for child in node.get_children():
		array = get_all_children(child, array)
	return array
