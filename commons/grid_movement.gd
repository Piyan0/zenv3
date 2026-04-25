class_name GridMovement

var target: Node2D
var tile_size= Vector2(16,16)
var can_move= func(dir): return true
var on_direction_changed= func(dir, prev_dir): pass
var routes= [Vector2.DOWN]:
    set(value):
        routes= value
        _start_move()
        
var delay= 0
var speed= 30

var _dir= Vector2.ZERO
var _prev_dir= Vector2.ZERO
var _t: Tween
var _dir_before_stop
var _is_stop= false
var _is_moving= false


func _init(p_target):
    target= p_target


func update(_delta):
    if !_is_moving: return
    var move_status= can_move.call(_dir)
    if move_status:
        pass
    else:
        _t.pause()    


func _start_move():
    _is_moving= true
    _t= target.create_tween()
    var pos= target.position
    for i in routes:
        pos+= tile_size * i
        _t.tween_callback(func():
            _invoke_direction_changed(i)
        )
        _t.tween_interval(delay)
        _t.tween_property(target, "position", pos, _get_speed())
    
    await _t.finished
    _is_moving= false
        

func _invoke_direction_changed(dir):
    _dir= dir
    if _dir != _prev_dir:
        on_direction_changed.call(_dir, _prev_dir)
    _prev_dir= _dir


func _get_speed():
    return tile_size.x / float(speed)
