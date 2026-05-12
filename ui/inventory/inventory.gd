class_name Inventory
extends CanvasLayer
signal inventory_closed(items_used)

static var last_used_item = 0
@export var items_id = [1, 2, 3, 4, 5, 6, 7 ,9]
@export var items_container: Control
@export var lb_desc: Label
@export var tr_item_icon: TextureRect
@export var desc_container: Control
@export var close_on_selected = false
var filter_item = func(item): return true
var _items_used = []

func _ready() -> void:
    var filtered_items_id = []
    for i in items_id:
        if filter_item.call(Bootstrap.items_database.get_item(i)):
            filtered_items_id.push_back(i)
    
    items_id = filtered_items_id
    desc_container.hide()
    _render_items()
    items_container.selection_change.connect(func(item):
        desc_container.show()
        lb_desc.text = item.description    
        if item.get_icon() == null:
            tr_item_icon.hide()
        else:
            tr_item_icon.texture= item.get_icon()
            tr_item_icon.show()
    )
    
    items_container.item_selected.connect(func(item, index):
        last_used_item = item.id
        if close_on_selected:
            inventory_closed.emit([item.id])
            queue_free()        
        if item.is_consumable:
            items_id.erase(item.id)
            _items_used.push_back(item.id)
            items_container.select_index = index
            _render_items()
        if items_id.is_empty():
            desc_container.hide()
        else:
            desc_container.show()
    )


func _input(event):
    if event.is_action_pressed("ui_cancel"):
        inventory_closed.emit(_items_used)
        queue_free()
        

func _render_items():
    var items = _get_items()
    items_container.render_items(items)
    

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
    var is_key_item = false
    var effect = func(): print("this is method to run when item is being used.")
    
    func get_icon():
        if icon_path.is_empty():
            return null
        return load(icon_path)
    
    
