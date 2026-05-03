class_name ItemsDatabase
extends Database


func _title():
    return "inventory_items"
    

func _base_path():
    return "res://assets/items_icon/"
    

func _target_class():
    return Inventory.Item.new()


func _get_items():
    var items= []
    _get_test_items(items)
    return items


func _get_test_items(items):
    items.push_back({
        "id" : 1,
        "name" : "letter",
        "description": "so this is...a letter maybe.",
        "icon_path" : "res://assets/16px.png",
        "is_consumable" : true,
        "effect" : func():
            print("anjay mabar")
    })
    
    items.push_back({
        "id" : 2,
        "name" : "key",
        "description" : "This is a key. Consumable.",
        "is_consumable" : true,
    })
