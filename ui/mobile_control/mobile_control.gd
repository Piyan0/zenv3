class_name MobileControl

func _init(p_owner, p_enabled):
    if !p_enabled:
        return
    
    var mobile_control= load("uid://bxxlmvxb1njx0").instantiate()
    p_owner.add_child.call_deferred(mobile_control)
    
