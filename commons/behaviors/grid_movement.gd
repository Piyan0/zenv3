class_name GridMovement
extends Node2D

@export var tile_size = 16
@export var target: Node2D
@export var speed= 60
var on_direction_changed= func(dir, prev_dir): pass

var _move_progress= 0.0
var _is_moving= false
var _direction = Vector2.DOWN
var _prev_direction= Vector2.ZERO
var _destination_pos
var _start_pos
var _default_speed

func _ready() -> void:
    _default_speed= speed
    pass


func _physics_process(delta: float) -> void:
    _update_input()
    _update_destination()
    _update_sprint_mode()
    _process_moving(delta)


func _update_input():
    if _is_moving:
        return

    if Input.is_action_pressed("ui_up"):
        _direction= Vector2.UP
    elif Input.is_action_pressed("ui_down"):
        _direction= Vector2.DOWN
    elif Input.is_action_pressed("ui_left"):
        _direction= Vector2.LEFT
    elif Input.is_action_pressed("ui_right"):
        _direction= Vector2.RIGHT
    else:
        _direction= Vector2.ZERO
    
    if _prev_direction!= _direction:
        on_direction_changed.call(_direction, _prev_direction)
    
    _prev_direction= _direction
    

func _update_destination():
    if _is_moving:
        return
    _start_pos= target.position
    _destination_pos= target.position + (Vector2(tile_size, tile_size) * _direction)


func _process_moving(delta):
    if _direction== Vector2.ZERO: return
    _is_moving= true
    var time= _get_time(speed)
    _move_progress+= delta / time
    target.position= lerp(_start_pos, _destination_pos, _move_progress)

    if _move_progress >= 1:
        _is_moving= false
        _move_progress= 0


func _update_sprint_mode():
    if Input.is_action_pressed("ui_cancel"):
        speed= _default_speed * 1.75
    else:
        speed= _default_speed
        

func _get_time(p_speed):
    return tile_size / float(p_speed)
    
