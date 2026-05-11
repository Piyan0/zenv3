class_name StaticIncrementVar
extends StaticEventCommand


@export var id = ""

func _command():
    assert(Bootstrap.progression.has_var(id), id)
    var eva = EventPageActions.new()
    eva.push(["increment_var", id])