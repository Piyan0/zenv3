extends Control


@export var icon: Texture2D
@export var item_name: String
@export var description: String
@export var _img_icon: TextureRect


func _ready() -> void:
    _img_icon.texture= icon
