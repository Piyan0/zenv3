class_name ItemsDatabase
extends Database


func _title():
    return "inventory_items"
    

func _base_path():
    return "res://assets/icon/"
    

func _target_class():
    return Inventory.Item.new()


func _get_items():
    var items= []
    _get_test_items(items)
    return items


func _get_test_items(items):
    items.push_back({
        "id": 0,
        "name" : "my_items",
        "description": "so this is en example item.",
        "icon_path": path("item_placeholder.png"),
    })
    
    items.push_back({
        "id": 1,
        "name" : "some cool items",
        "description": "anjay mabar.",
        "icon_path": path("item_placeholder.png"),
    })

