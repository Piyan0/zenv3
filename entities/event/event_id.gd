extends Label

@export var parent: Node

var _is_id_showned = false

func _ready() -> void:
    text = parent.name
    hide()
    parent.set_meta("toggle_id", toggle_id)


func toggle_id():
    if !OS.is_debug_build():
        return
    _is_id_showned = !_is_id_showned
    if _is_id_showned:
        show()
    else:
        hide()
    print(text)
    print(_is_id_showned)