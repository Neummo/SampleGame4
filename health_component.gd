extends Node2D
class_name HealthComponent

@export var health_bar: ProgressBar
@export var possesor: String
@export var damage_flash_player: AnimationPlayer
var health: int
var player: CharacterBody2D
var value: float

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	if possesor == "Player":
		health_bar = get_tree().get_first_node_in_group("HealthBar")

func damage(attack: Attack):
	if possesor == 'Player':
		if Values.player_invincible:
			return
		if health - attack.attack_damage <= 0:
			get_tree().set_deferred("paused", true)
			await get_tree().physics_frame
			await get_tree().process_frame
			get_tree().change_scene_to_packed(load("res://UI/MainMenu/menu.tscn"))
			return
		sub_damage(attack, true)
	else:
		sub_damage(attack, false)

func sub_damage(attack: Attack, is_player: bool) -> void:
	var dmg: int = int(floor(attack.attack_damage * Values.player_damage_multiplier))
	var critical: bool = false
	if is_player:
		if Values.player_can_mitigate and randf() <= Values.player_mitigate_chance:
			return
		if Values.player_can_reduce:
			dmg = maxi(1, dmg - Values.player_damage_reduction)
	else:
		if Values.player_can_crit and randf() <= Values.player_crit_chance:
			dmg *= int(floor(Values.player_crit_damage))
			critical = true
		if possesor != "Neutral":
			owner.dot_pool += dmg * Values.player_dot_percentage
	health -= dmg
	Values.display_number(dmg, "",  Vector2(position.x - 10, position.y - 30), "#e7e5d6", self, critical)
	damage_flash_player.play("damage_flash")
	if health <= 0:
		Values.eliminations += 1
		if Values.player_can_leech and Values.player_leech_amount > 0:
			player.heali(int(floor(Values.player_leech_amount)))
		if possesor == 'Neutral':
			spawn_instance(load("res://Pickups/Currency.tscn"), true)
			Values.neutral_count -= 1
		else:
			if owner is Boss:
				spawn_instance(load("res://Pickups/Currency.tscn"))
				return
			if owner is Bounty:
				var bounty_track = get_tree().get_first_node_in_group("BountyButton")
				bounty_track.disable_bounty()
				spawn_instance(load("res://Pickups/Currency.tscn"))
				return
			if spawn_part():
				spawn_instance(load("res://Pickups/part.tscn"))
			elif spawn_module():
				spawn_instance(load("res://Pickups/module.tscn"))
			elif spawn_item():
				spawn_instance(load("res://Pickups/Item.tscn"))
			else:
				spawn_instance(load("res://Pickups/Currency.tscn"))
		return
	else:
		health_bar.health = health

func spawn_instance(pickup: Resource, _neutral: bool = false) -> void:
	var instance = pickup.instantiate()
	instance.spawn_position = global_position
	instance.value = value * Values.currency_multiplier
	get_tree().current_scene.add_child.call_deferred(instance)
	if is_instance_valid(owner):
		owner.die()

func spawn_item() -> bool:
	if Values.item_spawn_chance >= randf():
		Values.item_spawn_chance = maxf(0.01, Values.item_spawn_chance - 0.001)
		return true
	return false

func spawn_module() -> bool:
	if Values.module_spawn_chance >= randf():
		Values.module_spawn_chance = maxf(0.01, Values.module_spawn_chance - 0.002)
		return true
	return false

func spawn_part() -> bool:
	return Values.part_spawn_chance >= randf()
