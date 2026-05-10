class_name TransitionBlack
extends Node

var fade_duration= 0.5
var start_from_black= false
var fade_color= Color.BLACK
var _overlay= null

static func spawn(p_start_from_black= false, p_color= Color.BLACK, p_dur= 0.5):
    var instance= TransitionBlack.new()
    instance.start_from_black= p_start_from_black
    instance.fade_color= p_color
    instance.fade_duration= p_dur
    Bootstrap.add_child.call_deferred(instance)
    await instance.ready
    await instance._start()
    return instance
    

func _exit_tree() -> void:
    if is_instance_valid(_overlay):
        _overlay.queue_free()
    
func confirm():
    await _fade_out()
    _overlay.queue_free()
    queue_free()
    

func _start():
    _overlay= await _add_overlay()
    await _fade_in()


func _fade_in():
    if start_from_black:
        _overlay.modulate= Color.WHITE
    else:
        var t= _overlay.create_tween()
        t.tween_property(_overlay, "modulate", Color.WHITE, fade_duration)
        await t.finished


func _fade_out():
    var t= create_tween()
    t.tween_property(_overlay, "modulate", Color.TRANSPARENT, fade_duration)
    await t.finished
    
    
func _add_overlay():
    var color_rect= ColorRect.new()
    # transition should have highest z-index.
    color_rect.z_index= 99
    color_rect.name= "Fade overlay"
    color_rect.color= fade_color
    color_rect.modulate= Color.TRANSPARENT
    color_rect.set_anchors_and_offsets_preset(Control.LayoutPreset.PRESET_FULL_RECT)
    Bootstrap.canvas.add_child.call_deferred(color_rect)
    await color_rect.ready
    return color_rect
