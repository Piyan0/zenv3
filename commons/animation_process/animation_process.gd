class_name AnimationProcess
extends Node
signal finished()

@export var target: Sprite2D
@export var animation_data: AnimationData

var pause= false
var _current_animation_idx= 0
var _elapsed_time= 0.0

func _process(delta: float):
    if pause || !animation_data: return
    if _current_animation_idx >= animation_data.frames_index.size():
        if animation_data.is_loop:
            _current_animation_idx= 0
        else:
            finished.emit()
            set_process(false)
            return

    _elapsed_time+= delta
    if _elapsed_time>= animation_data.delay_each_frame:
        _elapsed_time-= animation_data.delay_each_frame
        var texture= animation_data.get_texture(_current_animation_idx)
        target.texture= texture
        _current_animation_idx+= 1


func _ready():
    if animation_data:
        _initial_frame()


# TODO return if animation is same.
func change_animation(animation: AnimationData):
    animation_data= animation
    set_process(true)
    _initial_frame()


func _initial_frame():
    _elapsed_time= 0
    _current_animation_idx=1
    target.texture= animation_data.get_texture(0)
    target.offset= animation_data.offset
