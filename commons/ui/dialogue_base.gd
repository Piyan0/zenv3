class_name DialogueBase
signal batch_finished()
signal input_next()

var speed= 20
var dialogue_batch: Array[DialogueNormal]= []: set= _set_dialogue_batch
var on_progress= func(dialogue, visible_character, just_changed): pass

var _is_running_dialogue= false
var _t: Tween
var _just_changed= false
var _current_dialogue= ""


func input(event: InputEvent):
    if event.is_action_pressed("ui_accept"):
        if _is_running_dialogue:
            _skip(_current_dialogue)
            return
        input_next.emit()

        
func _set_dialogue_batch(value):
    if _is_running_dialogue:
        return
    dialogue_batch= value
    _start_batch(dialogue_batch)


func _skip(dialogue):
    _t.finished.emit()
    _t.kill()
    on_progress.call(dialogue, dialogue.msg.length(), false)


func _trigger_progress(visible_characters):
    on_progress.call(_current_dialogue, visible_characters, _just_changed)
    _just_changed= false
    

func _start_batch(p_dialogue_batch):
    for i: DialogueNormal in p_dialogue_batch:
        _t= Engine.get_main_loop().create_tween()
        _t.tween_method(_trigger_progress, 0, i.msg.length(), _get_speed(i.msg))
        _current_dialogue= i
        _is_running_dialogue= true
        _just_changed= true
        await _t.finished
        _is_running_dialogue= false
        await input_next
    
    batch_finished.emit()


func _get_speed(msg):
    return msg.length() / float(speed)


class DialogueNormal:
    var msg
    var speaker
    func _init(p_speaker, p_msg,):
        speaker= p_speaker
        msg= p_msg
