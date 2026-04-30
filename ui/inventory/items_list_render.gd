extends RenderableView

func _get_item(id):
    var item: Inventory.Item= Bootstrap.items_database.get_item(id)
    var item_view= load("res://ui/inventory/inventory_item.tscn").instantiate()
    item_view.item_name= item.name
    item_view.description= item.description
    item_view.icon= item.get_icon()
    
    return item_view


func _effect_active(node):
    node.state_active()


func _effect_blur(node):
    node.state_blur()


func _select_end(node, id):
    print(id)
