class_name GridMovement

var target: Node2D
var tile_size= Vector2(16,16)
var can_move= func(tile_region): return true
var on_direction_changed= func(dir, prev_dir): pass
var on_claim_tile= func(tile_region): pass
var routes= [Vector2.DOWN]:
    set(value):
        routes= value
        _start_move()
        
var delay= 0
var speed= 5

var _dir= Vector2.ZERO
var _prev_dir= Vector2.ZERO
var _t: Tween
var _dir_before_stop
var _is_stop= false
var _is_moving= false
var _poll_move_status= false
var _blocked_tile_region

func _init(p_target):
    target= p_target


func update(_delta):
    if _poll_move_status:
        var move_status= can_move.call(_blocked_tile_region)
        if move_status:
            _poll_move_status= false
            _invoke_direction_changed(_dir_before_stop)
            _t.play()


func _start_move():
    _is_moving= true
    _t= target.create_tween()
    var pos= target.position
    for i in routes:
        _t.tween_callback(func():
            if delay <= 0.0: return
            _t.pause()
            _dir_before_stop= i
            _invoke_direction_changed(Vector2.ZERO)
            await Engine.get_main_loop().create_timer(delay).timeout
            _invoke_direction_changed(_dir_before_stop)
            _t.play()
            )
            
        pos+= tile_size * i
        _t.tween_callback(func():
            var tile_region= tile_size * i
            on_claim_tile.call(tile_region)
            if !can_move.call(tile_region):
                _dir_before_stop= _dir
                _invoke_direction_changed(Vector2.ZERO)
                _blocked_tile_region= tile_region
                _poll_move_status= true
                _t.pause()
            else:
                _invoke_direction_changed(i)
        )

        _t.tween_property(target, "position", pos, _get_speed())
        
    
    await _t.finished
    _invoke_direction_changed(Vector2.ZERO)
    _is_moving= false
        

func _invoke_direction_changed(dir):
    _dir= dir
    if _dir != _prev_dir:
        #print(_prev_dir)
        on_direction_changed.call(_dir, _prev_dir)
    _prev_dir= _dir


func _get_speed():
    return tile_size.x / float(speed)
