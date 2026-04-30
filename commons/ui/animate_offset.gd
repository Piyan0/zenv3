class_name AnimateOffset
signal finished()

var start
var to
var time
var target

func _init(p_target, p_to, p_time, is_relative = true, p_start= null):
    target= p_target
    to= p_to
    time= p_time
    start= p_start
    _animate(is_relative)
    

func _animate(is_relative = true):
    if start!= null:
        target.position= start
    var t= target.create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    var end_pos = to
    if is_relative:
        end_pos += target.position
    t.tween_property(target, "position", end_pos, time)
    await t.finished
    finished.emit()
