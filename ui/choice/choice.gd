class_name Choice
extends MarginContainer

signal _choices_added()
signal choice_selected(choice_id)

@export var choices: Array[String] = ["Yes.", "No."]
@export var choice_container: Control
var _select : ListSelect

func _ready():
    await _add_choices()
    
    
static func spawn(pos, p_choices = ["Yes.", "No."] as Array[String], in_ui = false):
    var choice_node = load("uid://c85noq02lrvw1").instantiate()
    choice_node.choices = p_choices
    choice_node.modulate.a = 0
    if !in_ui:
        Bootstrap.world_canvas.add_child(choice_node)
    else:
        Bootstrap.canvas.add_child(choice_node)
    await choice_node._choices_added
    choice_node.global_position = pos
    choice_node.global_position += Vector2(-(choice_node.size.x/2) , -(choice_node.size.y))
    choice_node.modulate.a = 1
    var result = await choice_node.choice_selected
    return result
    

func _add_choices():
    for i in choice_container.get_children():
        i.free()
    
    for i in choices:
        var choice = load("uid://bv6ixu8e4crfw").instantiate()
        choice.msg = i
        choice_container.add_child(choice)
    
    await get_tree().process_frame
    set_offsets_preset(Control.LayoutPreset.PRESET_TOP_LEFT)
    _select = ListSelect.new(self, choice_container.get_children(), 0, VERTICAL)
    _select.on_select_end = func(s, a):
        choice_selected.emit(_select.get_current_index())
        queue_free()

    await get_tree().process_frame

    _choices_added.emit()
