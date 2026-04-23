class_name GridMovement
extends Node2D

@export var unit_size= 16
@export var target: Node2D
@export var speed= 10
@export var enabled_input= true

var _routes= []
var _current_routes: Array[Vector2]
var _current_dir: Vector2
var _current_start_pos: Vector2
var _is_moving= false


func _physics_process(delta: float) -> void:
    pass


func _process_movement(delta):
    pass


func _get_time():
    return float(unit_size) / speed
