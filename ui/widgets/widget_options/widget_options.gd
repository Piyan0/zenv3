extends Widget

@export var options: Array[String]= ["Salwa", "Hawa", "Manyssa"]
@export var hand_pointer: HandPointer
@export var lb_active_option: Label
@export var arrow_animate: Array[AnimateOffsetLoop]
@export var dot_instance: Control
@export var dot_container: HBoxContainer


func _enter_tree():
    var longest_text= ""
    for i in options:
        if i.length() > longest_text.length():
            longest_text= i
    
    var lb= lb_active_option.duplicate()
    add_child(lb)
    lb.hide()
    lb.text= longest_text
    await get_tree().process_frame
    lb_active_option.custom_minimum_size.x= lb.size.x
    for i in arrow_animate:
        i.setup()
    lb.queue_free()
    
func _prepare():
    dot_instance.reparent(self)
    dot_instance.hide()
    state_data= options
    _add_dots(options.size())
    key_event["ui_left"]= func():
        state= _move_option_index(state, -1)
        
    key_event["ui_right"]= func():
        state= _move_option_index(state, 1)
        

func _move_option_index(prev_idx, add_by):
    var new_index= (prev_idx + add_by + options.size()) % options.size()
    return new_index


func _set_active_dot(active_idx):
    for i in range(0, options.size()):
        var dot= dot_container.get_child(i)
        if i == active_idx:
            dot.modulate.a= 1
        else:
            dot.modulate.a= 0.5


func _add_dots(count):
    for i in range(0, count):
        var dot= dot_instance.duplicate()
        dot.show()
        dot_container.add_child(dot)


func _state_changed(state):
    _set_active_dot(state)
    lb_active_option.text= options[state]
    #print(value)
    

func _state_active():
    hand_pointer.state_active()
    

func _state_blur():
    hand_pointer.state_blur()
