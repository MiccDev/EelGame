extends CharacterBody2D
class_name Player

@export var speed = 100.0
@export var zap_radius = 5

var original_scale: Vector2

func _ready():
	original_scale = scale

func _process(_delta):
	if Input.is_action_pressed("zap"):
		var areas = ($ZapArea).get_overlapping_areas()
		for area in areas:
			if area.is_in_group("hooks"): 
				area.emit_signal("line_zap", self)

func _physics_process(_delta):
	var mouse_position = get_global_mouse_position()
	
	look_at(mouse_position)
	rotate(PI)
	
	if mouse_position.distance_to(position) > 1.5:
		var direction = (mouse_position - position).normalized()
		velocity = direction * speed
		move_and_slide()
