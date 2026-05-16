extends Node2D

signal move_finished()

@export var mark_size = Vector2(16,16)
@export var mark_speed = 30
@export var offset_from_target = 20
var _is_moving = false
var _t: Tween


func _ready() -> void:
    pass


func move_mark(pos: Vector2):
    if _is_moving:
        await move_finished

    if _t:
        if _t.is_valid():
            _t.kill()
    # 7,7 is hit spot so it is be center, and 12, 12 is self size so that is use center.
    var dir = ((pos + Vector2(7,7)) - (global_position - Vector2(12, 12))).normalized()
    var a_offset = dir * offset_from_target
    var b_offset = (dir * offset_from_target) * -1
    
    var start_pos = pos + a_offset
    var end_pos = pos + b_offset

    var get_time = func(distance):
        return float(distance) / mark_speed


    _t= create_tween().set_loops().set_trans(Tween.TransitionType.TRANS_SINE)
    
    _t.tween_callback(func():
        _is_moving = true
    )
    _t.tween_property(self, "global_position", start_pos, get_time.call(pos.distance_to(start_pos)))
    _t.tween_property(self, "global_position", end_pos, get_time.call(pos.distance_to(end_pos)))
    _t.tween_callback(func():
        _is_moving = false
        move_finished.emit()    
    )    


func is_hit(target_rect: Rect2):
    var self_rect = Rect2(global_position, mark_size)
    return target_rect.intersects(self_rect)