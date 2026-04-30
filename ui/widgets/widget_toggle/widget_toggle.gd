extends Widget

@export var hand_pointer: HandPointer
@export var img_state: TextureRect
@export var texture_on: Texture2D
@export var texture_off: Texture2D


func _enter_tree():
    hand_pointer.msg= title
    
    
func _prepare():
    state_data= [false, true]
    key_event["ui_accept"]= func():
        if state == 1:
            state= 0
        else:
            state= 1


func _state_changed(state):
    if state== 1:
        img_state.texture= texture_on
    else:
        img_state.texture= texture_off


func _state_active():
    hand_pointer.state_active()
    

func _state_blur():
    hand_pointer.state_blur()
