extends CanvasLayer

signal finished(is_succed)

@export var correct_answer = [2,2,2,2]
@export var parts: Array[Control]
@export var switch = ""
@export var switch_value = ""

func _ready():
    for i in parts:
        i.changed.connect(func(id):
            if _is_correct():
                set_process_unhandled_input(false)
                await get_tree().create_timer(0.5).timeout
                if !switch.is_empty():
                    var eva = EventPageActions.new()
                    eva.push(["set_switch", switch, switch_value])
                finished.emit(true)
                queue_free()
        )


    var select = ListSelect.new(self, parts, 0, HORIZONTAL)
    select.on_select_end = func(s, a):
        s.up()


func _unhandled_input(e):
    if e.is_action_pressed("ui_cancel"):
        queue_free()
        finished.emit(false)
    
    
static func spawn():
    var ins = load("uid://cwjago2h6rcsv").instantiate()
    Bootstrap.canvas.add_child(ins)
    return await ins.finished
    

func _is_correct():
    var answer = []
    for i in parts:
        answer.push_back(i.get_value())
    
    return answer == correct_answer
    
