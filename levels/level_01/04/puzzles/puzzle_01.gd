extends Node2D

@export var enable_on_switch = "[empty]"
@export var correct_answer: Array[int] = [0,0]
@export var switch_correct = "[empty]"
@export var switch_correct_value = true
@export var switch_wrong = "[empty]"
@export var switch_wrong_value = true
@export var label_hint: Label

@export var icon_container: Control

var _step_count = 0
var _current_answer = []



func _ready() -> void:
    if OS.is_debug_build():
        label_hint.text = str(correct_answer)
    else:
        label_hint.hide()

    if enable_on_switch != "[empty]":
        if !Bootstrap.progression.get_switch(enable_on_switch):
            for i in get_children():
                if i is StepArea:
                    i.disable()
            return

    for i in get_children():
        if i is StepArea:
            _step_count += 1
            i.stepped.connect(func(id):
                if !Bootstrap.progression.get_switch(enable_on_switch):
                    return 
                _add_icon(i.icon)
                _current_answer.push_back(id)
                if _current_answer.size() == correct_answer.size():
                    if _current_answer == correct_answer:
                        if enable_on_switch != "[empty]":
                            Bootstrap.progression.set_switch(enable_on_switch, false)  
                        _reset_step()
                        if switch_correct != "[empty]":
                            Bootstrap.progression.set_switch(switch_correct, switch_correct_value)  
                    else:
                        await _reset_step()
                        if switch_wrong != "[empty]":
                            Bootstrap.progression.set_switch(switch_wrong, switch_wrong_value)  
                    _current_answer = []
            )


func _reset_step():
    await get_tree().create_timer(0.5).timeout

    for i in icon_container.get_children():
        i.queue_free()

    for i in get_children():
        if i is StepArea:
            i.reset()

    
func _add_icon(icon):
    var tr_icon = TextureRect.new()
    tr_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
    tr_icon.texture = icon
    icon_container.add_child(tr_icon)
