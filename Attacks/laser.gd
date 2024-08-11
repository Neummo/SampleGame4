extends Ray
class_name Laser

@export var aoe: Area2D
@export var aoe_shape: CollisionShape2D
@export var range_indicator: Line2D
@export var line: Line2D
@export var casting_particles: GPUParticles2D
@export var collision_particles: GPUParticles2D
@export var beam_particles: GPUParticles2D
var is_casting: bool = false
var damaged: bool = false
var is_aoe: bool = false
var aoe_radius: float = 50.0
var gun_name: String = "Laser"

func _ready():
	set_physics_process(false)
	line.points[1] = Vector2.ZERO
	aoe_shape.get_shape().set_radius(aoe_radius)

func _physics_process(_delta: float) -> void:
	var cast_point: Vector2 = target_position
	force_raycast_update()
	collision_particles.emitting = is_colliding()
	if is_colliding():
		if not damaged:
			var collider: Area2D = get_collider()
			if collider is HitboxComponent:
				if is_aoe:
					aoe_damage(collider.global_position)
				else:
					var attack: Attack = Attack.new()
					attack.attack_damage = damage
					collider.damage(attack)
				damaged = true
		cast_point = to_local(get_collision_point())
		collision_particles.global_rotation = get_collision_normal().angle()
		collision_particles.position = cast_point
	
	if cast_point:
		line.points[1] = cast_point
	else:
		line.points[1] = target_position
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5
	
func aoe_damage(impact_position: Vector2):
	range_indicator.spawn_position = aoe_shape.global_position
	range_indicator.radius = aoe_radius
	range_indicator.width = 1.0
	range_indicator.draw_range_indicator()
	var tween = create_tween()
	tween.tween_property(range_indicator, "width", 0, 0.6)
	
	aoe.global_position = impact_position
	var physics_params: PhysicsShapeQueryParameters2D = PhysicsShapeQueryParameters2D.new()
	var physics_space_state: PhysicsDirectSpaceState2D
	physics_space_state = get_world_2d().direct_space_state

	physics_params.set_shape(aoe_shape.get_shape()) 
	physics_params.set_transform(aoe_shape.global_transform)
	physics_params.set_collision_mask(1)
	physics_params.set_collide_with_bodies(false)
	physics_params.set_collide_with_areas(true)
	var query_results = physics_space_state.intersect_shape(physics_params)
	
	for result in query_results:
		var area = result.collider
		if area is HitboxComponent and area.possesor == "Enemy":
			var attack: Attack = Attack.new()
			attack.attack_damage = damage
			area.damage(attack)

func set_is_casting(cast: bool) -> void:
	is_casting = cast
	
	beam_particles.emitting = is_casting
	casting_particles.emitting = is_casting
	if is_casting:
		appear()
	else:
		collision_particles.emitting = false
		disappear()
	set_physics_process(is_casting)
	
func appear() -> void:
	var tween = create_tween()
	tween.tween_property(line, "width", 5.0, 0.1)
	await tween.finished
	set_is_casting(false)
	
func disappear() -> void:
	var tween = create_tween()
	tween.tween_property(line, "width", 0, 0.1)
	damaged = false
