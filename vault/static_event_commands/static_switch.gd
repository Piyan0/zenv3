class_name StaticSwitch
extends StaticEventCommand

@export var switch: String
@export var value = true

func _command():
    Bootstrap.progression.set_switch(switch, value)