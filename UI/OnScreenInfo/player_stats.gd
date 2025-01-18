extends Stat
class_name PlayerStats

@export var acceleration_label: Label
@export var max_speed_label: Label
@export var max_health_label: Label
@export var hps_label: Label
@export var leech_label: Label
@export var damage_reduction_label: Label
@export var damage_mitigation_label: Label
@export var range_label: Label
@export var magnet_strengh_label: Label
@export var critical_chance_label: Label
@export var critical_damage_label: Label
@export var damage_multiplier_label: Label
@export var as_multiplier_label: Label
@export var salvage_drop_rate_label: Label
@export var part_drop_rate_label: Label
@export var credit_multiplier_label: Label
@export var credits_label: Label
@export var parts_label: Label
@export var modules_label: Label
@export var dash_cooldown: TextureRect
@export var hyper_cooldown: TextureRect
@export var bounty: Label
@export var coords: Label
@export var zone: Label

func set_stats(stats: Dictionary) -> void:
	acceleration_label.set_text(str(stats.acceleration))
	max_speed_label.set_text(str(stats.max_speed))
	max_health_label.set_text(str(stats.max_health))
	hps_label.set_text(str(stats.hps) + "/s")
	leech_label.set_text(str(stats.leech))
	damage_reduction_label.set_text(str(stats.damage_reduction))
	damage_mitigation_label.set_text(str(stats.damage_mitigation * 100) + "%")
	range_label.set_text(str(stats.range))
	magnet_strengh_label.set_text(str(stats.magnet_strengh))
	critical_chance_label.set_text(str(stats.critical_chance * 100) + "%")
	critical_damage_label.set_text(str(stats.critical_damage * 100) + "%")
	damage_multiplier_label.set_text(str(stats.damage_multiplier * 100) + "%")
	as_multiplier_label.set_text(str(stats.as_multiplier * 100) + "%")
	salvage_drop_rate_label.set_text(str(stats.salvage_drop_rate * 100) + "%")
	part_drop_rate_label.set_text(str(stats.part_drop_rate * 100) + "%")
	credit_multiplier_label.set_text(str(stats.currency_multiplier * 100) + "%")
	credits_label.set_text(str(snappedf(stats.credits, 0.01)))
	parts_label.set_text(str(stats.parts))
	modules_label.set_text(str(stats.modules))
	zone.set_text("Danger Level: " + str(stats.zone))
	refresh_action_bar()

func refresh_action_bar() -> void:
	if Values.dash_unlocked:
		dash_cooldown.set_visible(true)
	if Values.lightspeed_unlocked:
		hyper_cooldown.set_visible(true)
