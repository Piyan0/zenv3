class_name ItemsDatabase
extends Database

# TODO implement hidden items
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

# TODO use asset loader for image.
func _get_test_items(items):
    items.push_back({
        "id" : 1,
        "name" : "item_id_card",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_keycard.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    items.push_back({
        "id" : 2,
        "name" : "item_lab_liquid",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_lab_liquid.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    items.push_back({
        "id" : 3,
        "name" : "item_battery",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_battery.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    items.push_back({
        "id" : 4,
        "name" : "item_vaccine",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_vaccine.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    items.push_back({
        "id" : 5,
        "name" : "item_baseball_bat",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_bat.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    items.push_back({
        "id" : 6,
        "name" : "item_gas",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_gasoline.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    items.push_back({
        "id" : 7,
        "name" : "item_flint",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_lighter.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    items.push_back({
        "id" : 8,
        "name" : "item_scope",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    items.push_back({
        "id" : 9,
        "name" : "item_green_crystal",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_crystal.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    items.push_back({
        "id" : 10,
        "name" : "item_green_liquid",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_energy.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    items.push_back({
        "id" : 11,
        "name" : "item_drawing",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_drawing.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    items.push_back({
        "id" : 12,
        "name" : "item_flower",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_flower.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    
    items.push_back({
        "id" : 13,
        "name" : "item_watering_can",
        "description": "no_desc",
        "icon_path" : "res://assets/chloe/items/item_watercan.png",
        "is_consumable" : false,
        "is_key_item" : true,
    })
    
    