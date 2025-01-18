extends AreaBeam
class_name EnemyAreaBeam

@export var line: Line2D
@export var shape: CollisionShape2D
var is_casting: bool = false
var damaged: bool = false
var gun_name: String = "AreaBeam"
var closest_enemy: Area2D
var is_charging: bool = false
var charge_time: float
var laser_tween

func _ready():
	set_physics_process(false)
	line.points[1] = Vector2.ZERO
	shape.get_shape().size = Vector2(Values.enemy_range * 2, Values.zone + 10)
	shape.position.x = shape.get_shape().size.x / 2

func _physics_process(_delta: float) -> void:
	var cast_point: Vector2 = Vector2(Values.enemy_range * 2, 0)
	if not damaged and is_casting:
		for area in get_overlapping_areas():
			if area is HitboxComponent and area.possesor == "Player":
				var attack: Attack = Attack.new()
				attack.attack_damage = damage
				area.damage(attack)
		damaged = true
	line.points[1] = cast_point

func shoot() -> void:
	if is_charging == false:
		is_charging = true
		indicate()

func indicate() -> void:
	set_physics_process(true)
	line.default_color = Color8(255, 135, 135, 100)
	laser_tween = create_tween()
	laser_tween.tween_property(line, "width", 15.0, 3.0)
	await laser_tween.finished
	set_is_casting(true)

func set_is_casting(cast: bool) -> void:
	line.width = 0
	is_casting = cast
	line.default_color = Color8(250, 0, 60, 255)
	if is_casting:
		appear()
	else:
		disappear()
	set_physics_process(is_casting)
	
func appear() -> void:
	laser_tween = create_tween()
	laser_tween.tween_property(line, "width", shape.get_shape().size.y, 0.2)
	await laser_tween.finished
	set_is_casting(false)
	
func disappear() -> void:
	laser_tween = create_tween()
	laser_tween.tween_property(line, "width", 0, 1)
	damaged = false
	is_charging = false

func stop_tweens() -> void:
	laser_tween.kill()
	line.width = 0
