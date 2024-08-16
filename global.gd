extends Node

var currency: int = 15000

var safe_zone: bool = false
var player_max_health: int = 100
var player_health_regen: float = 0.1

var melee_gun_unlocked: bool = false
var player_melee_gun_speed: float = 1000.0
var player_melee_gun_range: float = 100.0
var player_melee_gun_damage: int = 10
var player_melee_gun_cooldown: float = 0.5

var manual_gun_unlocked: bool = false
var manual_gun_homing: bool = false
var player_manual_gun_damage: int = 20
var player_manual_gun_cooldown: float = 1
var player_manual_gun_speed: float = 200

var ult_gun_unlocked: bool = false

var ult_gun_aoe_unlocked: bool = false
var ult_gun_aoe_radius: float = 50.0

var ult_gun_pierce_unlocked: bool = false
var ult_gun_pierce_width: float = 10.0

var player_ult_gun_damage: int = 30
var player_ult_gun_cooldown: float = 1

var player_acceleration: float = 100.0
var player_max_speed: float = 200.0

var enemy_damage: int = 5
var enemy_health: int = 100
var enemy_acceleration: float = 50
var enemy_speed: float = 50
var enemy_range: float = 200.0
var enemy_projectile_speed: float = 300.0
