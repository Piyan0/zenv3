extends Node

@export var speed = 20
@export var tile_size = 16
var prev_anim = ""

func _ready():
    var p = get_parent()
    p.set_meta("walk_down", func():
        _move(Vector2.DOWN, "")
    )

func _move(dir, anim):
    var p = get_parent()
    
    var t = create_tween()
    var calc_pos = func():
        return dir * tile_size
    
    var time = func():
        return p.global_position.distance_to(p.global_position + calc_pos.call()) / float(speed)
        
    t.tween_property(get_parent(), "global_position", p.global_position + calc_pos.call(), time.call())
    await t.finished


