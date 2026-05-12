class_name DebugLabel
extends Label

func _enter_tree() -> void:
    if !OS.is_debug_build():
        queue_free()