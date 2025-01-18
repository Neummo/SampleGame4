extends Area2D

@export var projectile: Projectile
var already_hit: bool = false

func _on_area_entered(area):
	if area is HitboxComponent:
		if projectile.target == area.possesor:
			if already_hit and projectile is not Seeker:
				return
			if projectile is RocketHoming and projectile.is_aoe:
				projectile.aoe_damage(projectile.global_position)
				projectile.set_physics_process(false)
				projectile.sprite.set_visible(false)
				await projectile.tween.finished
				projectile.queue_free()
				already_hit = true
			else:
				var hitbox: HitboxComponent = area
				var attack: Attack = Attack.new()
				attack.attack_damage = projectile.damage
				hitbox.damage(attack)
				already_hit = true
				if projectile is Seeker:
					return
				projectile.queue_free()
		else:
			if projectile is Seeker:
				if projectile.closest_enemy == null and projectile.has_to_return:
					projectile.queue_free()
					Values.seeker_gun_active_amount -= 1
					return
				if not projectile.no_return and already_hit:
					projectile.queue_free()
					Values.seeker_gun_active_amount -= 1
