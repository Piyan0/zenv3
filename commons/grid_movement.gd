class_name GridMovement
extends Node

signal movement_finished()

var target: Node2D
var tile_size= Vector2(16,16)
var can_move= func(tile_region): return true
var on_direction_changed= func(dir, prev_dir): pass
var on_claim_tile= func(tile_region): pass
var repeat = false
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
var _poll_move_status= false
var _blocked_tile_region
var _cb_to_run_after_stop: Callable

func _init(p_target):
    target= p_target
    p_target.add_child.call_deferred(self)
    


func update(_delta):
    if _poll_move_status:
        var move_status= can_move.call(_blocked_tile_region)
        if move_status:
            _poll_move_status= false
            _cb_to_run_after_stop.call()
            


func get_direction():
    return _dir
    
    
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
            _t.play()
            var tile_region= tile_size * i
            if !can_move.call(tile_region):
                _dir_before_stop= i
                _invoke_direction_changed(Vector2.ZERO)
                _blocked_tile_region= tile_region
                _poll_move_status= true
                _t.pause()
                _cb_to_run_after_stop= func():
                    _invoke_direction_changed(_dir_before_stop)
                    _t.play()
            )
        _t.tween_callback(func():
            var tile_region= tile_size * i
            on_claim_tile.call(tile_region)
            if !can_move.call(tile_region):
                _dir_before_stop= _dir
                _invoke_direction_changed(Vector2.ZERO)
                _blocked_tile_region= tile_region
                _poll_move_status= true
                _t.pause()
                _cb_to_run_after_stop= func():
                    _invoke_direction_changed(_dir_before_stop)
                    _t.play()
        )
        pos+= tile_size * i
        _t.tween_callback(func():
            _invoke_direction_changed(i)
        )

        _t.tween_property(target, "position", pos, _get_speed())
        
    await _t.finished
    _handle_movement_finished()
    _invoke_direction_changed(Vector2.ZERO)
    _is_moving= false
        

func _handle_movement_finished():
    if repeat:
        var inverted_routes = func():
            var r = []
            var routes_reversed = routes.duplicate()
            routes_reversed.reverse()
            for i: Vector2 in routes_reversed:
                r.push_back(i * -1)
            return r
        
        var new_routes = inverted_routes.call()
        routes = new_routes
    else:
        movement_finished.emit()


func _invoke_direction_changed(dir):
    _dir= dir
    if _dir != _prev_dir:
        #print(_prev_dir)
        on_direction_changed.call(_dir, _prev_dir)
    _prev_dir= _dir


func _get_speed():
    return tile_size.x / float(speed)
