class_name EventPageActions

enum Direction{
    UP, DOWN, LEFT, RIGHT
}

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
    
    _actions["set_iswitch"] = func(internal_switch, value):
        var id = EventManager.current_internal_switch_id
        #print(id, internal_switch, value)
        Bootstrap.progression.set_internal_switch(id, str(internal_switch), value)
        
    _actions["get_iswitch"] = func(event_name, internal_switch):
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
        
    _actions["goto"] = func(map_id, pos, dir):
        var tf_data = MapManager.PlayerTransferData.new()
        tf_data.map_id = map_id
        tf_data.spawn_pos = pos
        tf_data.direction = dir
        await Bootstrap.map_manager.goto(tf_data)
        
    _actions["spawn_animation_player"] = func(animation_id):
        pass
        
    _actions["spawn_animation_world"] = func(animation_id, pos):
        pass

    _actions["transfer"] = func(target: String, x , y):
        var instance = Player.instance
        if target != "player":
            instance = Event.get_by_id(target)
        
        if instance:
            var mk_transfer = "transfer"
            if instance.has_meta(mk_transfer):
                instance.get_meta(mk_transfer).call(Vector2(x,y))
    

    _actions["move"] = func(target: String, arr_dir: Array):
        var instance = Player.instance
        if target != "player":
            instance = Event.get_by_id(target)
        var parse_dir = func():
            var r = []
            for i in arr_dir:
                match i:
                    "up":
                        r.push_back(Vector2.UP)
                    "down":
                        r.push_back(Vector2.DOWN)
                    "left":
                        r.push_back(Vector2.LEFT)
                    "right":
                        r.push_back(Vector2.RIGHT)
            return r

        if instance:
            var mk_set_routes = "set_routes"
            if instance.has_meta(mk_set_routes):
                await instance.get_meta(mk_set_routes).call(parse_dir.call())


# first element (at index 0 should be the key of '_actions', rest is call arguments.)
func push(args = []):
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
    #print(_state["dialogue_batch"])
    var dialogue = load("uid://dws6emg1mc14n").instantiate()
    dialogue.portrait_data = DialoguePortraitData.new().get_data()
    Bootstrap.canvas.add_child(dialogue)
    dialogue.set_dialogue_batch(_state["dialogue_batch"])
    await dialogue.dialogue_finished
    _state.erase("dialogue_batch")
