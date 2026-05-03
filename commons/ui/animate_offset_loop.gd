class_name AnimateOffsetLoop
extends Node

@export var start_on_ready= true
@export var target: Control
@export var offset= Vector2.ZERO
@export var duration= 0.3


func _ready():
    if start_on_ready:
        setup()
    

func setup():
    await get_tree().process_frame
    var start_pos= target.position
    var anim_pos= start_pos + offset
    # target.top_level= true
    # target.global_position= start_pos
    _animate(start_pos, anim_pos)
    
    
func _animate(start_pos, end_pos):
    var t= create_tween().set_loops()
    t.tween_property(target, "position", end_pos, duration)
    t.tween_property(target, "position", start_pos, duration)
