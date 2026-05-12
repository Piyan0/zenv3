class_name DebugLabel
extends Label

func _enter_tree() -> void:
    #modulate = Color.TRANSPARENT
    if !OS.is_debug_build():
        modulate = Color.TRANSPARENT
