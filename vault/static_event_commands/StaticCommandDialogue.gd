class_name StaticCommandDialogue
extends StaticEventCommand

@export_multiline var dialogue_list: Array[String] = ["speaker$content."]

func _command():
    var dialogue_batch = [] as Array[DialogueBase.DialogueNormal]
    var ev_page = EventPageActions.new()
    for i in dialogue_list:
        var split_text = i.split("$")
        ev_page.push(["push_dialogue", tr(split_text[0]), tr(split_text[1])])
        
    await ev_page.push(["start_dialogue"])
