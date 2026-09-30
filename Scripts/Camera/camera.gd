class_name Camera
extends Camera3D

@export var target: Node3D

## The zone in which the camera lets the target move without following.
## Unit : screen space [0;1]
@export_range(0, 1) var dead_zone_horizontal: float = .5
## The zone in which the camera lets the target move without following.
## Unit : screen space [0;1]
@export_range(0, 1) var dead_zone_vertical: float = .5

var offset: Vector3
var gizmo: Node3D

func _ready() -> void:
	assert(target != null, "The camera target must be assigned")
	offset = global_position - target.global_position
	# Log.pr("offset :", offset)

# Log.pr("viewport rect : ", get_viewport().get_visible_rect())

func _process(_delta: float) -> void:
	#global_position = to_follow.global_position + offset
	var pos: Vector2 = get_target_position_on_screen()
	# Log.pr("pos in viewport : ", pos)


## Returns the target's position in the screen, in screen space units : Vector2([0;1],[0;1])
func get_target_position_on_screen() -> Vector2:
	var target_pos_on_screen: Vector2 = unproject_position(target.global_position)
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	# Log.pr("target pos on screen :", target_pos_on_screen)
	return target_pos_on_screen / viewport_size
