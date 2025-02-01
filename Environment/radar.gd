extends Node2D

func draw_radar_indicator(asteroid: CharacterBody2D):
	var sprite: Sprite2D = Sprite2D.new()
	var texture: Resource = load("res://Assets/entities/char_3202.png")
	sprite.scale = Vector2(0.5, 0.5)
	var script: Resource = load("res://Environment/indicator.gd")
	sprite.texture = texture
	sprite.set_script(script)
	sprite.asteroid = asteroid
	var mat: Resource = load("res://smooth.tres")
	sprite.material = mat
	sprite.set_visible(true)
	add_child(sprite)

func delete_radar_indicator(asteroid: CharacterBody2D):
	for child in get_children():
		if child is Sprite2D and child.asteroid == asteroid:
			child.call_deferred("queue_free")
