extends CharacterBody2D

var acceleration: float
var max_speed: float
@export var rotate_speed: float = 2.0

@export var progression_manager: ProgressionManager
@export var stats: PlayerStats

@export var health_bar: ProgressBar
@export var health: HealthComponent
@export var body: Node2D

@export var melee_gun: MeleeGun
@export var ranged_gun: RangedGun
@export var big_gun: BigGun

@export var range_indicator: Line2D

func _ready():
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	set_stats()

func _physics_process(delta):
	movement(delta)
	#simple_movement(delta)
	guns()
	move_and_slide()

func rotate_to_direction(delta):
	var direction = Input.get_axis("rotate_left", "rotate_right")
	body.rotate(sign(direction) * delta * get_rotation_speed())
	
func get_rotation_speed() -> float:
	#print((maxf(abs(velocity.x), abs(velocity.y)) - (max_speed * 2)) / -max_speed)
	return rotate_speed
	
func guns() -> void:
	if Input.is_action_just_pressed("shoot_ult"):
		big_gun.shoot()
		
	if Input.is_action_just_pressed("shoot"):
		ranged_gun.shoot()
	
	melee_gun.shoot()

func movement(delta: float) -> void:
	rotate_to_direction(delta)
	var move_dir = Input.get_axis("accelerate", "reverse")
	if move_dir == -1:
		velocity += Vector2(0, -acceleration).rotated(body.rotation + 1.57079633).normalized() * delta * acceleration
	elif move_dir == 1:
		velocity -= (Vector2(velocity.x, velocity.y) * delta)
	velocity = velocity.limit_length(max_speed)
	
func simple_movement(delta: float) -> void:
	var moving: bool = false
	if Input.is_action_pressed("accelerate"):
		velocity += Vector2(0, -acceleration).normalized() * delta * acceleration
		moving = true
	elif Input.is_action_pressed("reverse"):
		velocity += Vector2(0, acceleration).normalized() * delta * acceleration
		moving = true
	if Input.is_action_pressed("rotate_left"):
		velocity += Vector2(-acceleration, 0).normalized() * delta * acceleration
		moving = true
	elif Input.is_action_pressed("rotate_right"):
		velocity += Vector2(acceleration, 0).normalized() * delta * acceleration
		moving = true
	if not moving:
		velocity -= (Vector2(velocity.x, velocity.y) * delta)
	velocity = velocity.limit_length(max_speed)
	body.look_at(get_global_mouse_position())
	
func set_stats() -> void:
	range_indicator.radius = Values.player_melee_gun_range
	range_indicator.spawn_position = global_position
	range_indicator.draw_range_indicator()
	acceleration = Values.player_acceleration
	max_speed = Values.player_max_speed
	health.MAX_HEALTH = Values.player_max_health
	health_bar.update_max_health(Values.player_max_health)
	
	melee_gun.update_stats()
	ranged_gun.update_stats()
	big_gun.update_stats()
	
	stats.set_stats({
		acceleration = Values.player_acceleration,
		max_speed = Values.player_max_speed,
		max_health = Values.player_max_health,
		health_regen = Values.player_health_regen,
		level = progression_manager.level,
		
		turret = {
			damage = Values.player_melee_gun_damage,
			reload_speed = Values.player_melee_gun_cooldown,
			range = Values.player_melee_gun_range,
		},
		rocket = {
			damage = Values.player_manual_gun_damage,
			reload_speed = Values.player_manual_gun_cooldown,
		},
		laser = {
			damage = Values.player_ult_gun_damage,
			reload_speed = Values.player_ult_gun_cooldown,
		},
	})
