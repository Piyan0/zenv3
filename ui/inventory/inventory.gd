class_name Inventory
extends CanvasLayer

@export var _item_scene: PackedScene
@export var item_id: Array[int]

func _add_items():
    pass
    
    
class Item:
    extends Database.TargeClass
    
    var description
    var icon_path: String
    
    func get_icon():
        return load(icon_path)
    
    