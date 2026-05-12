extends Control
signal finished(correct)

@export var number_preview: Array[Label] = []
@export var number_container: Control
@export var switch = ""
@export var lb_hint: Label
var expected_number = [1, 2, 3 ,4]

var number = []

func _ready():
    lb_hint.text = str(expected_number)
    _sync_preview()
    var select = ListSelect.new(self, number_container.get_children())
    select.horizontal_item_count = 3
    select.on_select_end = func(s, a):
        number.push_back(s.id)
        _sync_preview()
        if number.size() == 4:
            select.set_pause(true)
            if _is_correct():
                set_process_unhandled_input(false)
                await _apply_modulate(Color.GREEN, 1)
                finished.emit(true)
                if !switch.is_empty():
                    var eva = EventPageActions.new()
                    eva.push(["set_switch", switch, true])
                queue_free()
            else:
                await _apply_modulate(Color.RED, 1)
                for i in number_preview:
                    i.text = ""
                await get_tree().create_timer(0.5).timeout     
                number.clear()
                select.set_pause(false)


func _unhandled_input(e):
    if e.is_action_pressed("ui_cancel"):
        queue_free()
        finished.emit(false)
        
        
static func spawn(p_expected = [1, 2, 3, 4], p_switch = "", on_end = func(is_correct): pass):
    var ins = load("uid://5sg71r5xpdew").instantiate()
    ins.expected_number = p_expected
    ins.switch = p_switch
    Bootstrap.canvas.add_child(ins)
    var is_correct = await ins.finished
    await on_end.call(is_correct)
    
    
func _is_correct():
    return number == expected_number
    

func _sync_preview():
    if number.is_empty():
        #print(1)
        for i in number_preview:
            i.text = ""
        return
    
    for i in range(0, number.size()):
        number_preview[i].text = str(number[i])
    
    
func _apply_modulate(color, delay):
    for i in number_preview:
        var t = create_tween()
        t.tween_callback(func():
            i.modulate = color
        )
        t.tween_interval(delay)
        t.tween_callback(func():
            i.modulate = Color.WHITE
        )
    await get_tree().create_timer(delay).timeout
        
