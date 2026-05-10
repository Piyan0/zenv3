extends Node2D

@export var area: Area2D
@export var expected_box_id = "box"
@export var texture: Texture2D
@export var offset = Vector2.ZERO
@export var spr_main: Sprite2D


func _ready() -> void:
    spr_main.texture = texture
    spr_main.offset = offset


func box_exists():
    await get_tree().physics_frame
    await get_tree().physics_frame
    for i in area.get_overlapping_areas():
        var parent = i.owner
        if parent is SokobanBox:
            if parent.box_id == expected_box_id:
                return true

    return false