extends Area2D

@export var projectile: Projectile

func _on_area_entered(area):
	if area is HitboxComponent and projectile.target == area.possesor:
		var hitbox: HitboxComponent = area
		var attack: Attack = Attack.new()
		attack.attack_damage = projectile.damage
		hitbox.damage(attack)
		projectile.queue_free()
