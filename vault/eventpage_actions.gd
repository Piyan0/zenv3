class_name EventPageActions


var actions = {}


func _init() -> void:
    actions["push_dialogue"] = _queue_dialogue_batch
    actions["start_dialogue"] = _start_dialogue


func act(id, args = []):
    var result = await actions[id].callv(args) 
    return result


var _dialogue_batch : Array[DialogueBase.DialogueNormal]= []
func _queue_dialogue_batch(name, msg):
    _dialogue_batch.push_back(
        DialogueBase.DialogueNormal.new(name, msg)
    )


func _start_dialogue():
    var dialogue = load("uid://dws6emg1mc14n").instantiate()
    dialogue.dialogue_batch = _dialogue_batch
    Bootstrap.canvas.add_child(dialogue)
    _dialogue_batch = []
    await dialogue.dialogue_finished
