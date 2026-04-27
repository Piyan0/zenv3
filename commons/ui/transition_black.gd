class_name TransitionBlack
extends Node

signal continue_confirmed()

var fade_duration= 0.5
var start_from_black= false
var fade_color= Color.BLACK
var _overlay= null
var _t

static func spawn(p_start_from_black= false, p_color= Color.BLACK, p_dur= 0.5):
    var instance= TransitionBlack.new()
    instance.start_from_black= p_start_from_black
    instance.fade_color= p_color
    instance.fade_duration= p_dur
    Bootstrap.add_child.call_deferred(instance)
    await instance.ready
    await instance._start()
    return instance
    

func _start():
    _overlay= await _add_overlay()
    match start_from_black:
        false:
            await _start_fade_normal()
        true:
            await _start_fade_black()
    

func confirm():
    await _overlay.get_tree().process_frame
    await _overlay.get_tree().process_frame
    continue_confirmed.emit()
    
    
func _add_overlay():
    var color_rect= ColorRect.new()
    color_rect.name= "Fade overlay"
    color_rect.color= fade_color
    color_rect.modulate= Color.TRANSPARENT
    color_rect.set_anchors_and_offsets_preset(Control.LayoutPreset.PRESET_FULL_RECT)
    Bootstrap.canvas.add_child.call_deferred(color_rect)
    await color_rect.ready
    return color_rect
    
    
func _start_fade_normal():
    _t= _overlay.create_tween()
    _t.tween_property(_overlay, "modulate", Color.WHITE, fade_duration)
    await _t.finished
    _t= _overlay.create_tween()
    _t.tween_callback(func():
        _t.pause()
        await continue_confirmed
        _t.play()
    )
    _t.tween_property(_overlay, "modulate", Color.TRANSPARENT, fade_duration)
    await _t.finished
    queue_free()
    _overlay.queue_free()
    
    
func _start_fade_black():
    _overlay.modulate= Color.WHITE
    await _overlay.get_tree().process_frame
    _t= _overlay.create_tween()
    _t.tween_callback(func():
        _t.pause()
        await continue_confirmed
        _t.play()
    )
    _t.tween_property(_overlay, "modulate", Color.TRANSPARENT, fade_duration)
    await _t.finished
    queue_free()
    _overlay.queue_free()
    
    
