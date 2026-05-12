extends Control

signal finished(is_correct)

@export var img_state_open: Texture2D
@export var img_state_correct: Texture2D
@export var img_main: TextureRect

@export var expected_answer = [1, 2, 3]
@export var switch = ""

@export var liquid_list: Array[Control]
@export var lb_hint: Label

func _ready():
    lb_hint.text = str(expected_answer)
    var select = ListSelect.new(self, liquid_list, 0, HORIZONTAL)
    select.on_select_end = func(s, a):
        select.set_pause(true)
        await s.up()
        if _is_correct():
            set_process_unhandled_input(false)
            var t = create_tween()
            t.tween_callback(func():
                img_main.texture = img_state_correct
            )
            t.tween_interval(1)
            t.tween_callback(func():
                img_main.texture = img_state_open
            )
            t.tween_interval(1)
            await t.finished
            queue_free()
            finished.emit(true)
            
            if !switch.is_empty():
                var eva = EventPageActions.new()
                eva.push(["set_switch", switch, true])
        else:
            select.set_pause(false)
            
            
func _unhandled_input(e):
    if e.is_action_pressed("ui_cancel"):
        queue_free()
        finished.emit(false)


static func spawn(p_answer, p_switch = "", on_end = func(is_correct): pass):
    var ins = load("uid://cxmemask2emk3").instantiate()
    ins.expected_answer = p_answer
    ins.switch = p_switch
    Bootstrap.canvas.add_child(ins)
    var result = await ins.finished
    await on_end.call(result)


func _is_correct():
    var answer = liquid_list.map(func(i):
        return i.value
    )
    return answer == expected_answer
