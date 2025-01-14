extends AreaBeam

@export var line: Line2D
@export var casting_particles: GPUParticles2D
@export var beam_particles: GPUParticles2D
@export var shape: CollisionShape2D
var is_casting: bool = false
var damaged: bool = false
var gun_name: String = "AreaBeam"
var closest_enemy: Area2D

func _ready():
	damage = Values.player_ult_gun_damage
	set_physics_process(false)
	line.points[1] = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	var cast_point: Vector2 = Vector2(Values.player_range, 0)
	if not damaged:
		for area in get_overlapping_areas():
			if not is_instance_valid(area):
				continue
			if area.owner.dying:
				continue
			if area is HitboxComponent and area.possesor == "Enemy":
				var attack: Attack = Attack.new()
				attack.attack_damage = damage
				area.damage(attack)
		damaged = true
	line.points[1] = cast_point
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
	tween.tween_property(line, "width", shape.get_shape().size.y, 0.1)
	await tween.finished
	set_is_casting(false)
	
func disappear() -> void:
	var tween = create_tween()
	tween.tween_property(line, "width", 0, clampf(Values.player_ult_gun_cooldown / 2, 0.1, 0.5))
	damaged = false
