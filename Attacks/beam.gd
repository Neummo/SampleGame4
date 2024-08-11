extends PierceRay
class_name Beam

@export var line: Line2D
@export var casting_particles: GPUParticles2D
@export var beam_particles: GPUParticles2D
var is_casting: bool = false
var damaged: bool = false
var cast_point: Vector2 = Vector2.ZERO

func _ready():
	damage = Values.player_ult_gun_damage
	set_physics_process(false)
	line.points[1] = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	force_shapecast_update()
	if is_colliding():
		if not damaged:
			var collisions: int = get_collision_count()
			for index in collisions:
				var collider: Object = get_collider(index)
				if collider is HitboxComponent:
					var attack: Attack = Attack.new()
					attack.attack_damage = damage
					collider.damage(attack)
					cast_point = to_local(collider.global_position)
			damaged = true
	
	if cast_point:
		line.points[1] = cast_point
	else:
		line.points[1] = target_position
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5
	
func set_is_casting(cast: bool) -> void:
	is_casting = cast
	beam_particles.emitting = is_casting
	casting_particles.emitting = is_casting
	if is_casting:
		appear()
	else:
		disappear()
	set_physics_process(is_casting)
	
func appear() -> void:
	var tween = create_tween()
	tween.tween_property(line, "width", 5.0, 0.1)
	await tween.finished
	set_is_casting(false)
	
func disappear() -> void:
	var tween = create_tween()
	tween.tween_property(line, "width", 0, 0.5)
	damaged = false
