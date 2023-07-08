extends Node2D

signal line_cast
signal line_zap(other: Area2D)

@export_group("Line")
@export var line_cast_timer: Vector2i
@export var line_cast_range_around_player: Vector2i
@export var line_cast_depth_range: Vector2i
@export var line_cast_speed: float

@export_group("Hook")
@export var hook_radius: float = 5

@onready var cast_timer = $CastTimer
@onready var line = $Line2D
@onready var hook = $Hook

@onready var player: Player = get_node("/root/GameScene/Player")

var line_casted := false

var target_position: Vector2

func _ready():
	cast_timer.wait_time = randi_range(line_cast_timer.x, line_cast_timer.y)
	cast_timer.autostart = false
	cast_timer.start()
	
	line_zap.connect(_on_line_zap)

func _process(_delta):
	position.x = target_position.x
	
	var line_length = line.get_point_position(1)
	
	if line_length.y < target_position.y:
		line.set_point_position(1, Vector2(line_length.x, line_length.y + line_cast_speed))
		hook.position.y = line_length.y + 4
		if line_length.y >= target_position.y:
			line_casted = true
			line.set_point_position(1, Vector2(line_length.x, target_position.y))
		line_length = line.get_point_position(1)

##### SIGNALS #####

func _on_line_cast():
	target_position = Vector2(
		randf_range(
			player.position.x + line_cast_range_around_player.x,
			player.position.x + line_cast_range_around_player.y
		),
		randf_range(
			player.position.y + line_cast_depth_range.x, 
			player.position.y + line_cast_depth_range.y
		)
	)
	line.set_point_position(1, Vector2(0, 0))
	cast_timer.stop()

func _on_line_zap(_other: Player):
	print(_other)
	line.default_color = Color.DIM_GRAY
	line.queue_redraw()

func _on_cast_timer_timeout():
	emit_signal("line_cast")
