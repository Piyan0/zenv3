class_name AnimateOpenCenter
extends Node

signal finished()

var parent: Node
var target: Control
var duration


func _init(p_parent, p_target, p_duration= 0.2):
    parent= p_parent
    target= p_target
    duration= p_duration
    _animate()


func _animate():
    target.modulate= Color.TRANSPARENT
    var clone= target.duplicate()
    
    clone.top_level= true
    clone.size= target.size
    clone.global_position= target.global_position
    clone.modulate= Color.WHITE
    
    var half_size= target.size.y / 2
    var start_size_y= 0
    var end_size_y= target.size.y
    var start_pos= clone.global_position + Vector2(0, half_size)
    var end_pos= target.position
    
    parent.add_child.call_deferred(clone)
    await clone.ready
    
    clone.size.y= start_size_y
    clone.global_position= start_pos
    
    var t= clone.create_tween().set_parallel().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    t.tween_property(clone, "global_position", end_pos, duration)
    t.tween_property(clone, "size:y", end_size_y, duration)
    
    await t.finished

    finished.emit()
    target.modulate= Color.WHITE
    clone.free()
    queue_free()
    
    
    
