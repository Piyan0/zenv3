class_name Inventory
extends CanvasLayer

@export var items_container: Control
@export var items_id: Array[int]= [1, 1, 2, 1, 2, 2, 1, 2, 2 ,2]
@export var lb_desc: Label



func _ready() -> void:
    _render_items()
    items_container.selection_change.connect(func(item):
        lb_desc.text = item.description    
    )
    items_container.item_selected.connect(func(item, index):
        item.effect.call()
        if item.is_consumable:
            var new_items_id = items_id.duplicate()
            new_items_id.pop_at(index)
            items_id = new_items_id
            items_container.select_index = index
            _render_items()
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
    var is_consumable = true
    var effect = func(): print("this is method to run when item is being used.")
    
    func get_icon():
        return load(icon_path)
    
    
