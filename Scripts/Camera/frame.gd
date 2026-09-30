@tool
class_name Frame
extends Node2D

@export var debug: bool = false

@onready var camera: Camera = $".."

var rect: Rect2 = Rect2(50, 50, 100, 100)

@onready var viewport_rect: Rect2 = get_viewport().get_visible_rect()
@onready var offset_x: float = camera.dead_zone_horizontal * viewport_rect.size.x / 2
@onready var offset_y: float = camera.dead_zone_vertical * viewport_rect.size.y / 2
@onready var center: Vector2 = viewport_rect.get_center()
@onready var top_left: Vector2 = center + Vector2(-offset_x, -offset_y)
@onready var bottom_left: Vector2 = center + Vector2(-offset_x, offset_y)
@onready var bottom_right: Vector2 = center + Vector2(offset_x, offset_y)
@onready var top_right: Vector2 = center + Vector2(offset_x, -offset_y)

func _draw() -> void:
	if not debug or not OS.is_debug_build():
		return

	var color: Color = Color.RED
	var width: float = 2
	draw_line(top_left, bottom_left, color, width)
	draw_line(bottom_left, bottom_right, color, width)
	draw_line(bottom_right, top_right, color, width)
	draw_line(top_right, top_left, color, width)
