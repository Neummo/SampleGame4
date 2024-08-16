extends Stat
class_name EnemyStats

func set_stats(stats: Dictionary) -> void:
	acceleration = stats["acceleration"]
	max_speed = stats["max_speed"]
	max_health = stats["max_health"]
