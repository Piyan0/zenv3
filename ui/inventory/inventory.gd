class_name Inventory
extends CanvasLayer

@export var items_container: Control
@export var item_scene: PackedScene
@export var items_id: Array[int]= [1, 1, 2, 1, 2, 2, 1]
@export var lb_name: Label
@export var lb_desc: Label

var _item_select_idx= 0
var _select: ListSelect

func _ready():
    _render_items()


func _before_render():
    for i in items_container.get_children():
        i.queue_free()
    if is_instance_valid(_select):
        _select.queue_free()
    

func _after_render():
    if items_id.is_empty():
        print("null")
        
        
func _render_items():
    _before_render()
    var items= _get_items()
    var item_view_list= []
    for i: Item in items:
        var item_view= item_scene.instantiate()
        item_view.icon= i.get_icon()
        item_view.item_name= i.name
        item_view.description= i.description
        items_container.add_child(item_view)
        item_view_list.push_back(item_view)
    
    _setup_select(item_view_list, _item_select_idx)
    _after_render()


func _setup_select(nodes, start_idx):
    _select= ListSelect.new(self, nodes, start_idx, -1)
    _select.horizontal_item_count= 2
    
    _select.effect_active= func(node):
        lb_desc.text= node.description
        lb_name.text= node.item_name
        node.state_active()
        
    _select.effect_blur= func(node):
        node.state_blur()
    _select.bind_index(self, "_item_select_idx")
    _select.on_select_end= func(s, a):
        var new_ids= items_id.duplicate()
        new_ids.pop_at(_select.get_current_index())
        items_id= new_ids
        if _item_select_idx > items_id.size()-1:
            _item_select_idx-= 1
        _item_select_idx= max(0, _item_select_idx)
        _render_items()
        
        
func _get_items():
    var items= []
    for i in items_id:
        var item= Bootstrap.items_database.get_item(i)
        items.push_back(item)
    return items
    
    
class Item:
    extends Database.TargetClass
    
    var description
    var icon_path: String
    
    func get_icon():
        return load(icon_path)
    
    
