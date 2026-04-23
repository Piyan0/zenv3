class_name AnimateOffset
signal finished()

var start
var to
var time
var target

func _init(p_target, p_to, p_time, p_start= null):
    target= p_target
    to= p_to
    time= p_time
    start= p_start
    _animate()
    

func _animate():
    if start!= null:
        target.position= start
    var t= target.create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    t.tween_property(target, "position", target.position+to, time)
    await t.finished
    finished.emit()
