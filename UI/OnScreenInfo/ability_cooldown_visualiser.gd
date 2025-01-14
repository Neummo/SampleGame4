extends TextureRect

@onready var cooldown: TextureProgressBar = $Cooldown
@onready var timer: Timer = $Timer
var active: bool = false

func _ready() -> void:
	set_process(false)

func _process(_delta: float) -> void:
	cooldown.value = timer.time_left

func activate(wait_time: float) -> void:
	active = true
	timer.wait_time = wait_time
	cooldown.max_value = timer.wait_time
	timer.start()
	set_process(true)

func _on_timer_timeout() -> void:
	active = false
	cooldown.value = 0
	set_process(false)
