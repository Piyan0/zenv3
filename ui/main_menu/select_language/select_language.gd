extends Control

signal language_selected(lang)


@export var french_btn: HandPointer
@export var en_btn: HandPointer

func _ready() -> void:
    var select = ListSelect.new(self, [french_btn, en_btn], 0, HORIZONTAL)
    select.on_select_end = func(s, a):
        queue_free()
        if s == french_btn:
            language_selected.emit("fr_FR")
        else:
            language_selected.emit("en_US")


