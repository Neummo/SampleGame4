extends Ray
class_name EnemyLaser

@export var line: Line2D
@export var casting_particles: GPUParticles2D
@export var collision_particles: GPUParticles2D
@export var beam_particles: GPUParticles2D
@onready var shoot_timer: Timer = $ShootTimer

var is_charging: bool = false
var is_casting: bool = false
var last_collision_location: Vector2
var damaged: bool = false
var gun_name: String = "Laser"
var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	set_physics_process(false)
	line.points[1] = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	last_collision_location = to_local(player.global_position)
	var cast_point: Vector2 = target_position
	force_raycast_update()
	collision_particles.emitting = is_colliding() and is_casting
	if is_colliding():
		if not damaged and is_casting:
			var collider: Area2D = get_collider()
			if collider is HitboxComponent:
				var attack: Attack = Attack.new()
				attack.attack_damage = damage
				collider.damage(attack)
				damaged = true
		cast_point = to_local(get_collision_point())
		collision_particles.global_rotation = get_collision_normal().angle()
		collision_particles.position = cast_point
	
	cast_point = last_collision_location
	target_position = cast_point
	line.points[1] = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5
	
func set_is_casting(cast: bool) -> void:

	is_casting = cast
	
	#line.default_color = Color8(250, 0, 60, 255)
	beam_particles.emitting = is_casting
	casting_particles.emitting = is_casting
	if is_casting:
		appear()
	else:
		collision_particles.emitting = false
		disappear()

func shoot() -> void:
	if is_charging == false:
		is_charging = true
		indicate()

func indicate() -> void:
	set_physics_process(true)
	#line.default_color = Color8(255, 135, 135, 100)
	var tween = create_tween()
	tween.tween_property(line, "width", 15.0, 5.0)
	await tween.finished
	set_is_casting(true)

func appear() -> void:
	var tween = create_tween()
	tween.tween_property(line, "width", 15.0, 0.1)
	await tween.finished
	set_is_casting(false)
	
func disappear() -> void:
	var tween = create_tween()
	tween.tween_property(line, "width", 0, 0.5)
	await tween.finished
	set_physics_process(false)
	damaged = false
	is_charging = false

func _on_shoot_timer_timeout() -> void:
	set_is_casting(true)
