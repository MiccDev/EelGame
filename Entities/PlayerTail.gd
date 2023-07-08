extends Line2D

@export var follow_points: Array[Node2D]

func _ready():
	for i in range(0, len(follow_points)):
		points.append(Vector2(0, 0))

func _process(_delta):
	for i in range(0, len(follow_points)):
		var point = follow_points[i]
		set_point_position(0 if i == 0 else i - 1, point.position)
		
	
