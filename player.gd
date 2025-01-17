extends CharacterBody2D
class_name Player

var acceleration: float
var max_speed: float

@export var rotate_speed: float = 2.0

var progression_manager: ProgressionManager
var stats: PlayerStats

var health_bar: ProgressBar
@export var health: HealthComponent
@export var body: Node2D

@export var melee_gun: MeleeGun
@export var melee_gun2: MeleeGun
@export var melee_gun3: MeleeGun

@export var seeker_gun: SeekerGun
@export var ranged_gun: RangedGun
@export var big_gun: BigGun
@export var area_field: AreaField
@export var rng: Area2D
@export var range_indicator: Line2D
@export var radar: Node2D
@export var range_shape: CollisionShape2D
@export var camera: Camera2D
@export var return_trail: Line2D
@onready var return_timer: Timer = $ReturnTimer
@onready var return_animator: AnimatedSprite2D = $Body/ReturnAnimator
@onready var regen_timer: Timer = $RegenTimer

var closest_enemy: Area2D
var returning: bool = false
var charging_return: bool = false
var item_select: Control

func _ready():
	health_bar = get_tree().get_first_node_in_group("HealthBar")
	progression_manager = get_tree().get_first_node_in_group("ProgressionManager")
	stats = get_tree().get_first_node_in_group("PlayerStats")
	item_select = get_tree().get_first_node_in_group("ItemSelect")
	health.health = int(floor(Values.player_max_health * Values.player_max_health_multiplier))
	return_animator.set_visible(false)
	return_trail.set_physics_process(false)
	health_bar.init_health(int(floor(Values.player_max_health * Values.player_max_health_multiplier)))
	set_stats()

func _physics_process(delta):
	stats.coords.set_text("[" + str(snapped(global_position.x * 0.01, 1)) + ":" + str(snapped(global_position.y * 0.01 * -1, 1)) + "]")
	stats.zone.set_text("Danger Level: " + str(Values.zone))
	if charging_return:
		return_movement(delta)
	else:
		movement(delta)
	#simple_movement(delta)
	guns()
	move_and_slide()
	if Input.is_action_just_pressed("speed") and Values.lightspeed_unlocked:
		if returning:
			returning = false
			charging_return = false
			Values.player_invincible = false
			return_animator.stop()
			return_animator.set_visible(false)
			return_trail.clear_points()
			return_trail.set_physics_process(false)
			return
		elif charging_return == true:
			return
		else:
			if stats.hyper_cooldown.active:
				return
			stats.hyper_cooldown.activate(Values.lightspeed_cooldown)
			charging_return = true
			return_timer.start()
			return_animator.set_visible(true)
			return_animator.play("charging")
	if Input.is_action_just_pressed("zoom"):
		if camera.get_zoom() == Vector2(1, 1):
			camera.set_zoom(Vector2(0.4, 0.4))
		else:
			camera.set_zoom(Vector2(1, 1))
	if Input.is_action_just_pressed("money"):
		progression_manager.get_currency(100000)
		progression_manager.get_parts(100)
	if Input.is_action_just_pressed("switch_menu"):
		progression_manager.switch_menu()
	#if Input.is_action_just_pressed("dash") and Values.dash_unlocked:
		#if returning:
			#return
		#if stats.dash_cooldown.active:
			#return
		#if Input.is_action_pressed("left"):
			#velocity = Vector2(0, -Values.dash_str).rotated(body.rotation).normalized() * delta * Values.dash_str
			#stats.dash_cooldown.activate(Values.dash_cooldown)
		#if Input.is_action_pressed("right"):
			#velocity = Vector2(0, -Values.dash_str).rotated(-body.rotation).normalized() * delta * (Values.dash_str)
			#stats.dash_cooldown.activate(Values.dash_cooldown)
		#if Input.is_action_pressed("accelerate"):
			#velocity = Vector2(0, -Values.dash_str).rotated(body.rotation + 1.57079633).normalized() * delta * Values.dash_str
			#stats.dash_cooldown.activate(Values.dash_cooldown)
		#if Input.is_action_pressed("reverse"):
			#velocity = Vector2(0, -Values.dash_str).rotated(body.rotation - 1.57079633).normalized() * delta * Values.dash_str
			#stats.dash_cooldown.activate(Values.dash_cooldown)

func rotate_to_direction(_delta, weight: float):
	var dir: Vector2 = get_global_mouse_position() - body.global_position  #getting the direction (i'm making the node look at the mouse cursor in this example)
	var wantedrot : float = atan2(dir.y, dir.x) #grabbing our desired rotation in radians. Note that the Y direction comes first. (Not sure what the reason for this is, pretty sure it's just tradition)
	body.rotation = lerp_angle(body.rotation, wantedrot, weight)
	
func get_rotation_speed() -> float:
	return rotate_speed
	
func guns() -> void:
	get_closest_enemy()
	if closest_enemy:
		if Values.ult_gun_unlocked:
			big_gun.auto_shoot()
		if Values.manual_gun_unlocked:
			ranged_gun.shoot()
		if Values.seeker_gun_unlocked:
			seeker_gun.shoot()
		if Values.turret_second_upgrade_unlocked:
			melee_gun2.shoot()
			melee_gun3.shoot()
		elif Values.melee_gun_unlocked:
			melee_gun.shoot()

func get_closest_enemy() -> Area2D:
	var overlapping_areas: Array[Area2D] = rng.get_overlapping_areas()
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
	rotate_to_direction(delta, 0.1)
	var move_dir = Input.get_axis("accelerate", "reverse")
	if move_dir == -1:
		velocity += Vector2(0, -acceleration).rotated(body.rotation + 1.57079633).normalized() * delta * acceleration
	elif move_dir == 1:
		velocity -= (Vector2(velocity.x, velocity.y) * delta) * 2
	velocity = velocity.limit_length(max_speed)

func return_movement(delta: float) -> void:
	if returning:
		velocity = Vector2(0, -acceleration).rotated(body.rotation + 1.57079633).normalized() * delta * 100000
		rotate_to_direction(delta, 0.002)
	else:
		velocity -= (Vector2(velocity.x, velocity.y) * delta) * 2
		rotate_to_direction(delta, 0.1)

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
	health.health = int(floor(Values.player_max_health * Values.player_max_health_multiplier))
	health_bar.health = int(floor(Values.player_max_health * Values.player_max_health_multiplier))

func heali(hl: int) -> void:
	if health.health >= int(floor(Values.player_max_health * Values.player_max_health_multiplier)):
		return
	if health.health + hl > int(floor(Values.player_max_health * Values.player_max_health_multiplier)):
		hl = int(floor(Values.player_max_health * Values.player_max_health_multiplier)) - health.health
	health.health += hl
	health_bar.health += hl

func set_stats() -> void:
	range_indicator.radius = Values.player_range
	range_indicator.spawn_position = global_position
	range_indicator.draw_range_indicator()
	range_shape.get_shape().set_radius(Values.player_range)
	#var zoom: float = -0.001 * Values.player_range + 1.4
	#camera.set_zoom(Vector2(zoom, zoom))
	health_bar.update_max_health(int(floor(Values.player_max_health * Values.player_max_health_multiplier)))
	acceleration = Values.player_acceleration * Values.player_acceleration_multiplier
	max_speed = Values.player_max_speed * Values.player_max_speed_multiplier
	
	area_field.update_stats()
	melee_gun.update_stats()
	melee_gun2.update_stats()
	melee_gun3.update_stats()
	ranged_gun.update_stats()
	big_gun.update_stats()
	seeker_gun.update_stats()

	if Values.player_can_hps and Values.player_hps > 0:
		regen_timer.start()
	else:
		regen_timer.stop()
	
	stats.set_stats({
		acceleration = int(floor(Values.player_acceleration * Values.player_acceleration_multiplier)),
		max_speed = int(floor(Values.player_max_speed * Values.player_max_speed_multiplier)),
		max_health = int(floor(Values.player_max_health * Values.player_max_health_multiplier)),
		hps = Values.player_hps,
		leech = Values.player_leech_amount,
		damage_reduction = Values.player_damage_reduction,
		damage_mitigation = Values.player_mitigate_chance,
		range = Values.player_range,
		magnet_strengh = Values.pickup_speed,
		critical_chance = Values.player_crit_chance,
		critical_damage = Values.player_crit_damage,
		damage_multiplier = Values.player_damage_multiplier,
		salvage_drop_rate = Values.item_spawn_chance,
		part_drop_rate = Values.part_spawn_chance,
		as_multiplier = Values.attack_speed_modifier,
		currency_multiplier = Values.currency_multiplier,
		credits = Values.currency,
		parts = Values.parts,
		zone = Values.zone
	})

func _on_atmosphere_area_entered(area):
	if area is HitboxComponent and area.possesor == "Player":
		Values.player_invincible = true

func _on_atmosphere_area_exited(area):
	if area is HitboxComponent and area.possesor == "Player":
		Values.player_invincible = false

func _on_return_timer_timeout() -> void:
	Values.player_invincible = true
	returning = true
	return_trail.set_physics_process(true)
	return_animator.play("returning")

func _on_visible_range_area_exited(area: Area2D) -> void:
	if area.get_parent() is Projectile:
		area.get_parent().queue_free()

func _on_regen_timer_timeout() -> void:
	heali(Values.player_hps)
