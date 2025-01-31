extends Area2D
class_name Pickup

@onready var player: CharacterBody2D
var spawn_position: Vector2
@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $"."
@onready var hitbox_shape: CollisionShape2D = $CollisionShape2D
var instant: bool = false
var uuid: int

func _ready() -> void:
	uuid = Time.get_ticks_msec()
	player = get_tree().get_first_node_in_group("Player")
	global_position = spawn_position
	instant = Values.pickup_speed_instant

func _physics_process(delta: float) -> void:
	if instant:
		global_position = player.global_position
	else:
		var vel: Vector2 = Vector2(player.global_position - global_position)
		position += vel.normalized() * delta * Values.pickup_speed
		rotation += 0.01

func die() -> void:
	sprite.set_visible(false)
	set_process(false)
	set_physics_process(false)
	hitbox.set_deferred("monitorable", false)
	hitbox.set_deferred("monitoring", false)
