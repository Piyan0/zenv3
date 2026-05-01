class_name MobileControl

func _init(p_owner, p_enabled):
    if !p_enabled:
        return
    
    if OS.get_name() == "Android":
        var mobile_control= load("uid://bxxlmvxb1njx0").instantiate()
        p_owner.add_child.call_deferred(mobile_control)
        
