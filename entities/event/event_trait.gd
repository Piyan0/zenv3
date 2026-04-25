class_name EventTrait
extends Resource


func enter(event: Event):
    _enter(event)


func exit(event: Event):
    _exit(event)


func call_update(delta, event: Event):
    _update(delta, event)


func _enter(event: Event):
    pass


func _exit(event: Event):
    pass


func _update(delta, event):
    pass