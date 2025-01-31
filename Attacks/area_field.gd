extends AreaAttackType
class_name AreaField

var player: CharacterBody2D
var direction: int = 1
var amp: int = 2
var skip: int = 3
@onready var indicator: Line2D = $Line2D
@onready var field_area: CollisionShape2D = $FieldArea

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	update_stats()
	set_visible(false)
	set_physics_process(false)

func update_stats() -> void:
	field_area.get_shape().radius = Values.area_field_range
	damage = Values.area_field_damage
	if Values.area_field_unlocked:
		set_visible(true)
		set_physics_process(true)

func _physics_process(_delta: float) -> void:
	draw_range_indicator()

func draw_range_indicator():
	skip -= 1
	if skip != 0:
		return
	skip = 4
	direction *= -1
	indicator.clear_points()
	for i in range(0, 361):
		var angle: float = deg_to_rad(1.0 * i)
		if randf() >= 0.8:
			continue
		indicator.add_point(point_on_circle(angle, i))

func point_on_circle(angle: float, index: int) -> Vector2:
	var s: float = sin(angle)
	var c: float = cos(angle)
	var point: Vector2
	
	if direction > 0:
		if index % 2 == 0:
			point = Vector2(s * (Values.area_field_range + randi_range(0, amp)), c * (Values.area_field_range + randi_range(0, amp)))
		else:
			point = Vector2(s * (Values.area_field_range - randi_range(0, amp)), c * (Values.area_field_range - randi_range(0, amp)))
	else:
		if index % 2 == 0:
			point = Vector2(s * (Values.area_field_range - randi_range(0, amp)), c * (Values.area_field_range - randi_range(0, amp)))
		else:
			point = Vector2(s * (Values.area_field_range + randi_range(0, amp)), c * (Values.area_field_range + randi_range(0, amp)))
	return point

func damage_enemy(area: Area2D, multiplier: int) -> void:
	if is_instance_valid(area):
		if area.owner.dying:
			return
		var hitbox: HitboxComponent = area
		var attack: Attack = Attack.new()
		attack.attack_damage = damage * multiplier
		attack.attack_type = "Energy"
		hitbox.damage(attack)

func _on_area_entered(area: Area2D) -> void:
	if Values.area_field_unlocked and area is HitboxComponent and area.possesor == "Enemy":
		if Values.area_field_4x_exit_unlocked:
			return
		elif Values.area_field_2x_enter_unlocked:
			damage_enemy(area, 2)
		else:
			damage_enemy(area, 1)

func _on_area_exited(area: Area2D) -> void:
	if Values.area_field_unlocked and area is HitboxComponent and area.possesor == "Enemy":
		if Values.area_field_2x_enter_unlocked:
			return
		elif Values.area_field_4x_exit_unlocked:
			damage_enemy(area, 4)
		else:
			damage_enemy(area, 1)
