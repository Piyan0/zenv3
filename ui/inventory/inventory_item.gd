class_name InventoryItem
extends Control


@export var icon: Texture2D
@export var item_name: String
@export var description: String
@export var tr_icon: TextureRect
@export var hand_pointer: TextureRect

func _ready() -> void:
    tr_icon.texture= icon
    

func state_active():
    hand_pointer.show()
    modulate.a= 1


func state_blur():
    hand_pointer.hide()
    modulate.a= 0.5
