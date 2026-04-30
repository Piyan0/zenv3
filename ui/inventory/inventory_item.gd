class_name InventoryItem
extends Control


@export var icon: Texture2D
@export var item_name: String
@export var description: String
@export var _img_icon: TextureRect


func _ready() -> void:
    _img_icon.texture= icon
    

func state_active():
    modulate.a= 1


func state_blur():
    modulate.a= 0.5
