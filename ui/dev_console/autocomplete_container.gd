extends MarginContainer
signal selected(text)


@export var text_container : VBoxContainer
var _select : ListSelect


func _ready():
    selected.connect(func(text): hide(); _select.queue_free())


func _input(event: InputEvent) -> void:
    if event is InputEventKey:
        if event.keycode == KEY_ESCAPE && event.pressed:
            off()
            get_viewport().set_input_as_handled()


func off():
    hide()
    if is_instance_valid(_select):
        _select.queue_free()
        
        
func _before_render():
    show()
    if is_instance_valid(_select):
        _select.queue_free()
        

func set_autocomplete(text_list = []):
    _before_render()
    for i in text_container.get_children():
        i.queue_free()
    
    var instances = []
    for text in text_list:
        var instance = load("uid://b010mwqmsnscd").instantiate()
        instance.lb.text = text
        instance.text_pressed.connect(func(p_text): selected.emit(p_text))
        text_container.add_child(instance)
        instances.push_back(instance)
    
    #reset the size to it's minimum.
    await get_tree().process_frame
    size = Vector2.ZERO

    _select = ListSelect.new(self, instances, 0, VERTICAL)
    _select.effect_active = func(node):
        node.state_active()
    
    _select.effect_blur = func(node):
        node.state_blur()
    
    _select.on_select_end = func(node, all_nodes):
        node.emit_text_pressed()
