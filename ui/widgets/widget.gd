class_name Widget
extends Control

@export var title: String= "<widget>"
@export var state= 0:
    set(value):
        state= value
        _state_changed.call_deferred(value)
        
var state_data= []
var key_event= {}
var value:
    get():
        return _get_value()


func _ready():
    await _prepare()
    state= state
    

func _prepare():
    pass
    
    
func process_state_active():
    set_process_input(true)
    _state_active()
    
    
func process_state_blur():
    set_process_input(false)
    _state_blur()
    

# @virtual
func _state_changed(state):
    pass


# @virtual
func _state_blur():
    pass
    

# @virtual
func _state_active():
    pass
    
    
func _get_value():
    return {
        "state": state,
        "data": state_data
    }
    

func _input(event):
    if event is InputEventAction or event is InputEventKey:
        if !event.is_pressed():
            return
        var action_name= event.action
        if action_name in key_event:
            key_event[action_name].call()
