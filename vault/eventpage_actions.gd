class_name EventPageActions

enum Direction{
    UP, DOWN, LEFT, RIGHT
}

var _actions = {}
var _state = {}


func _init() -> void:
    _actions["narator"] = func(msg_arr):
        var narator_dialogue = [] as Array[DialogueBase.DialogueNormal]
        for i in msg_arr:
            narator_dialogue.push_back(
                NaratorView.NaratorDialogue.new(i)
            )
        var narator_view = load("uid://cqtqvc51an3sh").instantiate()
        narator_view.narator_dialogue = narator_dialogue
        Bootstrap.canvas.add_child(narator_view)
        await narator_view.finished
    
            
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
    
    _actions["add_item"] = func(id):
        Bootstrap.save_system.fields["items_id"].push_back(id)
    
    _actions["set_iswitch"] = func(internal_switch_str, value = true):
        var id = EventManager.current_internal_switch_id
        var internal_switch = EventPage.InternalSwitch[internal_switch_str.to_upper()]
        Bootstrap.progression.set_internal_switch(id, str(internal_switch), value)
        
    _actions["get_iswitch"] = func(event_name, internal_switch):
        pass
        
    _actions["set_switch"] = func(id, value = true):
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
    
    #TODO change dir into string. 
    _actions["goto"] = func(map_id, x, y, dir_str = "down", start_from_black = false):
        var dir
        match dir_str:
            "up":
                dir = MapManager.Direction.UP
            "down":
                dir = MapManager.Direction.DOWN
            "left":
                dir = MapManager.Direction.LEFT
            "right":
                dir = MapManager.Direction.RIGHT
                
        var tf_data = MapManager.PlayerTransferData.new()
        tf_data.map_id = map_id
        tf_data.spawn_pos = Vector2(x,y)
        tf_data.direction = dir
        await Bootstrap.map_manager.goto(tf_data, start_from_black)
        
    _actions["spawn_animation_player"] = func(animation_id):
        pass
        
    _actions["spawn_animation_world"] = func(animation_id, pos):
        pass

    _actions["transfer"] = func(target: String, x , y):
        var instance = Event.get_by_id(target)
        if target == "player":
            instance = Player.instance
       
        if instance:
            var mk_transfer = "transfer"
            if instance.has_meta(mk_transfer):
                instance.get_meta(mk_transfer).call(Vector2(x,y))
    
    
    _actions["look"] = func(target: String, dir_str = "up"):
        var instance = Event.get_by_id(target)
        if target == "player":
            instance = Player.instance
       
        if instance:
            var nk_look = "look"
            if instance.has_meta(nk_look):
                instance.get_meta(nk_look).call(dir_str)
    
    
    _actions["alpha"] = func(target: String, is_transparent = true):
        var instance = Event.get_by_id(target)
        if target == "player":
            instance = Player.instance
       
        if instance:
            var meta_key = "alpha"
            if instance.has_meta(meta_key):
                instance.get_meta(meta_key).call(is_transparent)
    

    _actions["move"] = func(target: String, arr_dir: Array, speed = 30):
        var instance = Event.get_by_id(target)
        if target == "player":
            instance = Player.instance
        
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
                await instance.get_meta(mk_set_routes).call(parse_dir.call(), speed)
    
    _actions["fade_in"] = func(free_at_end = false):
        var fade = await TransitionBlack.spawn()
        if free_at_end:
            fade.queue_free()
        else:
            _state["fade"] = fade
    
    _actions["fade_out"] = func(wait = false):
        if wait:
            await _state["fade"].confirm()
        else:
            _state["fade"].confirm()
    
    _actions["wait"] = func(second):
        await Engine.get_main_loop().create_timer(second).timeout
            

# first element (at index 0 should be the key of '_actions', rest is call arguments.)
func push(args = []):
    var id = args.pop_front()
    if id.is_empty():
        return
    # print("start push {id}".format({"id":id}), ">>",EventManager.current_internal_switch_id)
    var result = await _actions[id].callv(args) 
    # print("finished push {id}".format({"id":id}), ">>",EventManager.current_internal_switch_id)
    return result


func _queue_dialogue_batch(name, msg):
    if !"dialogue_batch" in _state:
        _state["dialogue_batch"]= [] as Array[DialogueBase.DialogueNormal]
    var d_batch = _state["dialogue_batch"]
    d_batch.push_back(
        DialogueBase.DialogueNormal.new(name, tr(msg))
    )


func _start_dialogue():
    #print(_state["dialogue_batch"])
    var dialogue = load("uid://dws6emg1mc14n").instantiate()
    dialogue.portrait_data = DialoguePortraitData.new().get_data()
    Bootstrap.canvas.add_child(dialogue)
    dialogue.set_dialogue_batch(_state["dialogue_batch"])
    await dialogue.dialogue_finished
    _state.erase("dialogue_batch")
