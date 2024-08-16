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
@export var range: Area2D
@export var range_indicator: Line2D
var closest_enemy: Area2D

func _ready():
	health_bar.init_health(Values.player_max_health)
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	set_stats()

func _physics_process(delta):
	stats.coords.set_text(str(snapped(global_position.x, 1), " ", snapped(global_position.y, 1)))
	movement(delta)
	#simple_movement(delta)
	guns()
	move_and_slide()

func rotate_to_direction(_delta):
	#var direction = Input.get_axis("rotate_left", "rotate_right")
	#body.rotate(sign(direction) * delta * get_rotation_speed())
	body.look_at(get_global_mouse_position())
	
func get_rotation_speed() -> float:
	#print((maxf(abs(velocity.x), abs(velocity.y)) - (max_speed * 2)) / -max_speed)
	return rotate_speed
	
func guns() -> void:
	#if Input.is_action_just_pressed("shoot_ult"):
		
	#if Input.is_action_just_pressed("shoot"):
	
	get_closest_enemy()
	if closest_enemy:
		if Values.ult_gun_unlocked:
			big_gun.auto_shoot()
		if Values.manual_gun_unlocked:
			ranged_gun.shoot()
		if Values.melee_gun_unlocked:
			melee_gun.shoot()

func get_closest_enemy() -> Area2D:
	var overlapping_areas: Array[Area2D] = range.get_overlapping_areas()
	var min_distance: float
	closest_enemy = null
	for area in overlapping_areas:
		if area is HitboxComponent and area.possesor != "Player":
			var distance_to_enemy: float = global_position.distance_squared_to(area.global_position)
			if not closest_enemy:
				min_distance = global_position.distance_squared_to(area.global_position)
				closest_enemy = area
			if distance_to_enemy < min_distance:
				min_distance = distance_to_enemy
				closest_enemy = area
	return closest_enemy

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

func heal() -> void:
	health.health = Values.player_max_health
	health_bar.health = Values.player_max_health

func set_stats() -> void:
	range_indicator.radius = 500
	range_indicator.spawn_position = global_position
	range_indicator.draw_range_indicator()
	acceleration = Values.player_acceleration
	max_speed = Values.player_max_speed
	health.health = Values.player_max_health
	health_bar.update_max_health(Values.player_max_health)
	
	melee_gun.update_stats()
	ranged_gun.update_stats()
	big_gun.update_stats()
	
	stats.set_stats({
		acceleration = Values.player_acceleration,
		max_speed = Values.player_max_speed,
		max_health = Values.player_max_health,
		health_regen = Values.player_health_regen,
		currency = Values.currency,
		
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

func _on_atmosphere_area_entered(area):
	if area is HitboxComponent and area.possesor == "Player":
		progression_manager.upgrade_menu.set_visible(true)

func _on_atmosphere_area_exited(area):
	if area is HitboxComponent and area.possesor == "Player":
		progression_manager.upgrade_menu.set_visible(false)
