class_name StaticNarator
extends StaticEventCommand


@export var narator_dialogue: Array[String]

func _command():
    var eva = EventPageActions.new()
    eva.push(["narator", narator_dialogue])