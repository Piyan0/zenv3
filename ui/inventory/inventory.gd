class_name Inventory
extends CanvasLayer

@export var items_container: Control
@export var item_scene: PackedScene
@export var items_id: Array[int]= [1, 1, 2, 1, 2, 2, 1]
@export var lb_name: Label
@export var lb_desc: Label

var _item_select_idx= 0
var _select: ListSelect

func _ready() -> void:
    pass
    
class Item:
    extends Database.TargetClass
    
    var description
    var icon_path: String
    
    func get_icon():
        return load(icon_path)
    
    
