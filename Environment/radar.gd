extends Node2D

var radius: float = 50.0

func draw_radar_indicator(asteroid: CharacterBody2D):
	var sprite: Sprite2D = Sprite2D.new()
	var texture: Resource = load("res://Assets/Ship_4.png")
	var script: Resource = load("res://Environment/indicator.gd")
	sprite.texture = texture
	sprite.scale = Vector2(0.2, 0.2)
	sprite.set_script(script)
	sprite.asteroid = asteroid
	sprite.set_visible(true)
	add_child(sprite)
