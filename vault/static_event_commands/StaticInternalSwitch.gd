class_name StaticInternalSwitch
extends StaticEventCommand

@export var internal_switch: EventPage.InternalSwitch
@export var value = true


func _command():
    var ev = EventPageActions.new()
    ev.push(["set_iswitch", internal_switch, value])