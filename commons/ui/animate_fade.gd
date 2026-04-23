class_name AnimateFade
signal finished

var from_transparent= false
var time= 1.0
var target

func _init(p_target, p_from_transparent, p_time= time):
    target= p_target
    from_transparent= p_from_transparent
    time= p_time
    _animate()
    

func _animate():
    var start_a= target.modulate.a
    var end_a= 0
    if from_transparent:
        start_a= 0
        end_a= 1
    target.modulate.a= start_a
    var t= target.create_tween()
    t.tween_property(target, "modulate:a", end_a, time)
    await t.finished
    finished.emit()
    

    
        
