extends CharacterBody2D

@export var health_component: HealthComponent
@export var health_bar: ProgressBar
@onready var sprite: Sprite2D = $Body/Sprite
@onready var hitbox: HitboxComponent = $Body/HitboxComponent
@onready var hitbox_shape: CollisionShape2D = $Body/HitboxComponent/CollisionShape2D
@onready var death: AnimatedSprite2D = $Body/Death

var rotation_speed: float = 50
var player: CharacterBody2D
var cluster_lead: bool = false
var cluster_leads: Array = []
var dying: bool = false

func _ready():
	var frames = sprite.texture.get_width() / sprite.region_rect.size.x
	var random_index: int = randi_range(0, frames - 1)
	sprite.region_rect.position.x = random_index * sprite.region_rect.size.x
	player = get_tree().get_first_node_in_group("Player")
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	health_component.health = Values.enemy_health
	health_component.value = 10.0 * Values.currency_multiplier_asteroid
	health_bar.init_health(Values.enemy_health) 

func _physics_process(_delta):
	if Values.radar_unlocked and cluster_lead and get_player_distance() < Values.radar_range and not cluster_leads.has(self):
		cluster_leads.append(self)
		player.radar.draw_radar_indicator(self)
	despawn()

func despawn() -> void:
	if get_player_distance() > 6000:
		Values.neutral_count -= 1
		cluster_leads.erase(self)
		queue_free()

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
	death.play("death")
	await death.animation_finished
	queue_free()
