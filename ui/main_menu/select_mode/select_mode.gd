extends Control

signal mode_selected(is_multiplayer)


@export var btn_solo: HandPointer
@export var btn_multi: HandPointer

func _ready() -> void:
    var select  = ListSelect.new(self, [btn_solo, btn_multi], 0, HORIZONTAL)
    select.on_select_end = func(s, a):
        queue_free()
        if s == btn_solo:
            mode_selected.emit(false)
        elif s == btn_multi:
            mode_selected.emit(true)