extends AreaAttackType
class_name EnemyAreaField

var direction: int = 1
var amp: int = 2
var skip: int = 3
@onready var indicator: Line2D = $Line2D
@onready var field_area: CollisionShape2D = $FieldArea

func _ready() -> void:
	field_area.get_shape().radius = 50 + Values.zone
	damage = Values.enemy_damage

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

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.owner is Player:
		var hitbox: HitboxComponent = area
		var attack: Attack = Attack.new()
		attack.attack_damage = damage
		hitbox.damage(attack)
