class_name AnimateOpenCenter
extends Node

signal finished()

var target: Control
var duration


func _ready() -> void:
    await target.get_tree().process_frame
    _animate()


static func spawn(p_target, p_duration= 0.2, on_start= func():pass, on_end= func(): pass):
    var instance= AnimateOpenCenter.new()
    instance.target= p_target
    instance.duration= p_duration
    Bootstrap.add_child.call_deferred(instance)
    # sometime _ready have to do initial calculation for ui, if we for example hide some ui before it initial frame,
    # when we access the size, it will be 0,0 (not processed by layout engine).
    on_start.call_deferred()
    await instance.finished
    on_end.call()


func _animate():
    var clone= target.duplicate()    
    clone.name= "OpenFromCenterNode"
    clone.size= target.size
    clone.global_position= target.global_position
    clone.modulate= Color.WHITE
    var half_size= target.size.y / 2
    var start_size_y= 0
    var end_size_y= target.size.y
    var start_pos= clone.global_position + Vector2(0, half_size)
    var end_pos= target.global_position
    
    Bootstrap.canvas.add_child.call_deferred(clone)
    await clone.ready
    
    clone.size.y= start_size_y
    clone.global_position= start_pos
    
    var t= clone.create_tween().set_parallel().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    t.tween_property(clone, "global_position", end_pos, duration)
    t.tween_property(clone, "size:y", end_size_y, duration)
    
    await t.finished
    finished.emit()
    clone.free()
    queue_free()
    
    
    
