extends TextureButton

@onready var timer: Timer = $Timer
@onready var bountry_price_label: Label = $BountryPriceLabel
@onready var current_price: int = 1000
var bounty_active: bool = false
var bounty: CharacterBody2D
var spawner: Node2D
var stats: PlayerStats
var pm: Node2D

func _ready() -> void:
	pm = get_tree().get_first_node_in_group("pm")
	stats = get_tree().get_first_node_in_group("PlayerStats")
	spawner = get_tree().get_first_node_in_group("Spawner")
	bountry_price_label.set_text(str(current_price))
	#if Values.currency < current_price or bounty_active or not Values.bounties_unlocked:
	#	set_disabled(true)
	#set_process(false)

func check_price() -> void:
	pass
	#if Values.currency < current_price or bounty_active or not Values.bounties_unlocked:
	#	set_disabled(true)
	#else:
	#	set_disabled(false)

func _process(_delta: float) -> void:
	if is_instance_valid(bounty):
		stats.bounty.set_text("[ " + str(snapped(bounty.global_position.x * 0.01, 1)) + " : " + str(snapped(bounty.global_position.y * 0.01 * -1, 1)) + " ]")

func disable_bounty() -> void:
	set_process(false)
	stats.bounty.set_text("..Scanning..")
	#bountry_price_label.set_text(str(current_price))
	timer.start()
	#bounty_active = false
	#check_price()

func activate() -> void:
	await spawner.spawn_bounty(int(floor(current_price / 1000)))
	bounty = get_tree().get_first_node_in_group("Bounty")
	if not is_instance_valid(bounty):
		print('bounty fcked')
		bounty = get_tree().get_first_node_in_group("Bounty")
	#Values.currency -= current_price
	bounty_active = true
	#bountry_price_label.set_text("Bounty Active")
	#set_disabled(true)
	bounty.health_component.value = 2000
	current_price = mini(current_price + 1000, 10000)
	set_process(true)
	#pm.check_prices()
	#pm.player.set_stats()


func _on_timer_timeout() -> void:
	activate()
