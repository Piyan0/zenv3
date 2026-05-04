class_name EventPageActions


var _actions = {}
var _state = {}


func _init() -> void:
    _actions["push_dialogue"] = _queue_dialogue_batch
    
    _actions["start_dialogue"] = _start_dialogue

    _actions["choices"] = func(p_choices, on_end_dict = {}):
        var choices = [] as Array[String]
        choices.assign(p_choices)
        var result = await Choice.spawn(Player.instance.position + Vector2(8, -28), choices)
        if result in on_end_dict:
            await on_end_dict[result].call()
            
        return result



func push(id, args = []):
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
