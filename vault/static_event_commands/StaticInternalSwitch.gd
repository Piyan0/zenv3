class_name StaticInternalSwitch
extends StaticEventCommand

@export var internal_switch: EventPage.InternalSwitch
@export var value = true


func _command():
    var ev = EventPageActions.new()
    var internal_switch_str = ""
    match internal_switch:
        1:
            internal_switch_str = "A"
        2:
            internal_switch_str = "B"
        3:
            internal_switch_str = "C"
        4:
            internal_switch_str = "D"
            
    ev.push(["set_iswitch", internal_switch_str, value])