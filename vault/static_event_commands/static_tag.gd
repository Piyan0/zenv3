class_name StaticTag
extends StaticEventCommand

enum Operation { ADD, REMOVE }

@export var tag = ""
@export var operation = Operation.ADD

func _command():
    var eva = EventPageActions.new()
    match operation:
        Operation.ADD:
            eva.push(["tag", tag])
        Operation.REMOVE:
            eva.push(["rtag", tag])