class_name ListSelect
extends Node

var horizontal_item_count= 0

var _mode= -1 # default is grid mode
var _current_idx= 0
var _node_list: Array[Control]=[]

var _pause= false
var on_select_change: Callable= func(selected_node, all_nodes: Array[Control]): pass
var on_select_end: Callable= func(selected_node, all_nodes: Array[Control]): pass


func _init(p_owner: Node, p_nodes, p_start_index= 0, p_mode= -1):
    _mode= p_mode
    _current_idx= p_start_index
    _node_list= p_nodes
    p_owner.add_child.call_deferred(self)
    await tree_entered
    var node= _node_list[_current_idx]
    on_select_change.call(node, _node_list)


func _input(event: InputEvent):
    if _pause:
        return

    _process_select_item(event)
    if _mode==-1:
        _process_input_grid(event)
    elif _mode== HORIZONTAL:
        _process_input_horizontal(event)
    elif _mode == VERTICAL:
        _process_input_vertical(event)
    

func get_current_index():
    return _current_idx


func set_pause(pause):
    if pause:
        _pause= true
    else:
        _selection_change(_current_idx)


func _process_select_item(event: InputEvent):
    if event.is_action_pressed("ui_accept"):
        var node= _node_list[_current_idx]
        on_select_end.call(node, _node_list)
        get_viewport().set_input_as_handled()


func _process_input_vertical(event: InputEvent):
    if event.is_action_pressed("ui_up"):
        _current_idx= _move_index(-1)
    elif event.is_action_pressed("ui_down"):
        _current_idx= _move_index(1)
    else:
        return
    get_viewport().set_input_as_handled() 
    _selection_change(_current_idx)


func _process_input_horizontal(event: InputEvent):
    if event.is_action_pressed("ui_left"):
        _current_idx= _move_index(-1)
    elif event.is_action_pressed("ui_right"):
        _current_idx= _move_index(1)
    else:
        return
    get_viewport().set_input_as_handled()
    _selection_change(_current_idx)


func _process_input_grid(event: InputEvent):

    if event.is_action_pressed("ui_left"):
        _current_idx= _move_index(-1)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("ui_right"):
        _current_idx= _move_index(1)
        get_viewport().set_input_as_handled()
    if event.is_action_pressed("ui_down"):
        _current_idx= _move_index(horizontal_item_count)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("ui_up"):
        _current_idx= _move_index(horizontal_item_count * -1)
        get_viewport().set_input_as_handled()
    _selection_change(_current_idx)


func _selection_change(idx):
    var node= _node_list[idx]
    on_select_change.call(node, _node_list)


func _move_index(add_by: int):
    var items_size= _node_list.size()
    var new_index= (_current_idx + add_by + items_size) % items_size
    return new_index
