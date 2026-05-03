class_name InventoryItem
extends Control

@export var icon: Texture2D
@export var item_name: String
@export var description: String
@export var hand_pointer: TextureRect
@export var lb_name: Label
@export var lb_index: Label


func _ready() -> void:
    lb_name.text = item_name


func set_index(idx):
    lb_index.text = str(idx).pad_zeros(2)+" "


func state_active():
    hand_pointer.show()
    modulate.a= 1


func state_blur():
    hand_pointer.hide()
    # modulate.a= 0.5
