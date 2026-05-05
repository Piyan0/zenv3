class_name EventPageActions


var _actions = {}
var _state = {}


func _init() -> void:
    _actions["push_dialogue"] = _queue_dialogue_batch
    
    _actions["start_dialogue"] = _start_dialogue

    _actions["choices"] = func(p_choices = [], on_end = func(choice_index): pass):
        var choices = [] as Array[String]
        choices.assign(p_choices)
        var result = await Choice.spawn(Player.instance.position + Vector2(8, -28), choices)
        await on_end.call(result)
    
    _actions["open_inventory"] = func(on_end = func(item_id): pass):
        var items = Bootstrap.save_system.fields["items_id"].duplicate()
        var inven = load("uid://c1148pqf8xuv8").instantiate()
        inven.filter_item = func(item):
            return item.is_key_item
            
        inven.close_on_selected = true
        inven.items_id = items
        Bootstrap.canvas.add_child(inven)
        var items_used = await inven.inventory_closed
        if items_used.is_empty():
            await on_end.call(-1)
            return
        await on_end.call(items_used[0])
    
    _actions["erase_item"] = func(id):
        Bootstrap.save_system.fields["items_id"].erase(id)
    
    _actions["set_internal_switch"] = func(event_name, internal_switch, value):
        pass
        
    _actions["get_internal_switch"] = func(event_name, internal_switch):
        pass
        
    _actions["set_switch"] = func(id, value):
        Bootstrap.progression.set_switch(id, value)
        
    _actions["get_switch"] = func(id, cb):
        var value = Bootstrap.progression.get_switch(id)
        await cb.call(value)
    
    _actions["set_var"] = func(id, value):
        Bootstrap.progression.set_var(id, value)
        
    _actions["get_var"] = func(id, cb):
        var value = Bootstrap.progression.get_var(id)
        await cb.call(value)
        
    _actions["show_image"] = func(img_id):
        await DisplayImage.spawn(img_id)
    
    _actions["has_item"] = func(item_id):
        pass
        
    _actions["goto"] = func(map_id, pos):
        pass

func push(args = []):
    # print(args)
    var id = args.pop_front()
    var result = await _actions[id].callv(args) 
    return result


func _queue_dialogue_batch(name, msg):
    if !"dialogue_batch" in _state:
        _state["dialogue_batch"]= [] as Array[DialogueBase.DialogueNormal]
    var d_batch = _state["dialogue_batch"]
    d_batch.push_back(
        DialogueBase.DialogueNormal.new(name, msg)
    )


func _start_dialogue():
    var dialogue = load("uid://dws6emg1mc14n").instantiate()
    dialogue.dialogue_batch = _state["dialogue_batch"]
    _state.erase("dialogue_batch")
    Bootstrap.canvas.add_child(dialogue)
    await dialogue.dialogue_finished
