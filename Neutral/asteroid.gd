extends CharacterBody2D

@export var health_component: HealthComponent
@export var health_bar: ProgressBar
@onready var sprite2: Sprite2D = $Body/Sprite
@onready var sprite: Sprite2D = $Body/Sprite2
@onready var hitbox: HitboxComponent = $Body/HitboxComponent
@onready var hitbox_shape: CollisionShape2D = $Body/HitboxComponent/CollisionShape2D
@onready var death: AnimatedSprite2D = $Body/Death

var rotation_speed: float = 50
var player: CharacterBody2D
var cluster_lead: bool = false
var cluster_leads: Array = []
var dying: bool = false

func _ready():
	var cols = 4
	var rows = 3
	var frame_width = 256 / cols
	var frame_height = 192 / rows
	var random_col = randi() % cols
	var random_row = randi() % rows
	sprite.region_enabled = true
	sprite2.region_enabled = true
	sprite.region_rect = Rect2(Vector2(random_col * frame_width, random_row * frame_height), Vector2(frame_width, frame_height))
	sprite2.region_rect = Rect2(Vector2(random_col * frame_width, random_row * frame_height), Vector2(frame_width, frame_height))
	
	player = get_tree().get_first_node_in_group("Player")
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	if cluster_lead:
		sprite.apply_scale(Vector2(1, 1))
		sprite2.apply_scale(Vector2(1, 1))
		health_component.health = Values.enemy_health * 5
		health_component.value = 30.0 * Values.currency_multiplier_asteroid
		health_bar.init_health(Values.enemy_health * 5) 
	else:
		health_component.health = Values.enemy_health
		health_component.value = 5.0 * Values.currency_multiplier_asteroid
		health_bar.init_health(Values.enemy_health)

func _physics_process(_delta):
	despawn()
	if not Values.radar_unlocked or not cluster_lead:
		return
	if get_player_distance() < Values.radar_range and not cluster_leads.has(self):
		cluster_leads.append(self)
		player.radar.draw_radar_indicator(self)
	elif get_player_distance() >= Values.radar_range and cluster_leads.has(self):
		cluster_leads.erase(self)
		player.radar.delete_radar_indicator(self)

func despawn() -> void:
	if get_player_distance() > 1500:
		Values.neutral_count -= 1
		cluster_leads.erase(self)
		call_deferred("queue_free")

func get_player_distance() -> float:
	return snapped(global_position.distance_to(player.global_position), 1)

func die() -> void:
	dying = true
	sprite.set_visible(false)
	health_bar.set_visible(false)
	set_process(false)
	set_physics_process(false)
	hitbox.set_deferred("monitorable", false)
	hitbox.set_deferred("monitoring", false)
	death.set_visible(true)
	death.play("death")
	await death.animation_finished
	call_deferred("queue_free")
