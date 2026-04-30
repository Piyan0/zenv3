extends Widget

const PROGRESS_MOVE_DURATION= 0.2

@export var meter_step= [0, 25, 50, 75, 100]
@export var hand_pointer: HandPointer
@export var progress_bar: TextureProgressBar

var _t: Tween

func _enter_tree():
    hand_pointer.msg= title
    key_event["ui_left"]= func():
        state= clamp(state-1, 0, meter_step.size()-1)
    key_event["ui_right"]= func():
        state= clamp(state+1, 0, meter_step.size()-1)


func _prepare():
    state_data= meter_step
    

func _state_changed(state):
    _move_progress_bar(state_data[state])
    

func _move_progress_bar(progress_value):
    if _t:
        if _t.is_valid():
            _t.custom_step(INF)

    _t= create_tween().set_trans(Tween.TransitionType.TRANS_EXPO).set_ease(Tween.EaseType.EASE_OUT)
    _t.tween_property(progress_bar, "value", progress_value, PROGRESS_MOVE_DURATION)
    
    
func _state_active():
    hand_pointer.state_active()
    

func _state_blur():
    hand_pointer.state_blur()
