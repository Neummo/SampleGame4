extends CharacterBody2D
class_name Enemy

@export var health_component: HealthComponent
@export var stats: EnemyStats
@export var health_bar: ProgressBar
@export var body: Node2D

@onready var dot_pool: int = 0
@onready var timer: Timer = $Timer
@onready var death: AnimatedSprite2D = $Body/Death
@onready var hitbox: HitboxComponent = $Body/HitboxComponent
@onready var hitbox_shape: CollisionShape2D = $Body/HitboxComponent/CollisionShape2D
@onready var sprite = $Body/Sprite
@onready var shoot_timer: Timer = $ShootTimer

var player: CharacterBody2D
var arrived: bool = false
var dying: bool = false

func _physics_process(delta):
	move_and_slide()
	
	if Values.player_can_dot:
		tick_dot()
	if Values.zone == 0:
		run(delta)
		return
	if arrived:
		behavior(delta)
		rotate_to_target(player, delta)
	else:
		arrive(delta)
		body.look_at(player.global_position)

func tick_dot() -> void:
	if dot_pool <= 0:
		timer.stop()
		return
	if not timer.is_stopped():
		return
	else:
		timer.start()

func rotate_to_target(_target, _delta):
	pass

func run(_delta: float) -> void:
	var dir = player.global_position - global_position
	body.look_at(global_position - dir)
	var vector: Vector2 = Vector2(stats.acceleration * 10, 0)
	velocity += (vector.rotated(body.rotation)).normalized() * _delta * stats.acceleration * 10

func get_player_distance() -> float:
	return snapped(global_position.distance_to(player.global_position), 1)

func behavior(_delta: float) -> void:
	pass

func arrive(delta: float) -> void:
	if global_position.distance_to(player.global_position) > Values.player_range * 3:
		velocity = (Vector2(stats.acceleration * 200000, 0).rotated(body.rotation)).normalized() * delta * 200000
	else:
		arrived = true

func die() -> void:
	dying = true
	if self is Enemy5 and is_instance_valid(self.laser.laser_tween):
		self.laser.stop_tweens()
	sprite.set_visible(false)
	if is_instance_valid(shoot_timer):
		shoot_timer.stop()
	health_bar.set_visible(false)
	set_process(false)
	set_physics_process(false)
	hitbox.set_deferred("monitorable", false)
	hitbox.set_deferred("monitoring", false)
	death.set_visible(true)
	death.play("death")
	await death.animation_finished
	queue_free()
