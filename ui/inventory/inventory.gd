class_name Inventory
extends CanvasLayer

@export var items_container: Control
@export var items_id: Array[int]= [1, 1, 2, 1, 2, 2, 1]
@export var lb_desc: Label

var _item_select_idx= 0
var _select: ListSelect


func _ready() -> void:
    _render_items()
    items_container.selection_change.connect(func(item):
        lb_desc.text = item.description    
    )


func _render_items():
    var items = _get_items()
    get_meta("_render_items").call(items)
    

func _get_items():
    var items = []
    for i in items_id:
        var item = Bootstrap.items_database.get_item(i)
        items.push_back(item)
    
    return items


class Item:
    extends Database.TargetClass
    
    var description
    var icon_path: String
    
    func get_icon():
        return load(icon_path)
    
    
