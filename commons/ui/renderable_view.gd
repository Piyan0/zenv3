class_name RenderableView
extends Control


enum EndAction{ DO_NOTHING, DELETE }
enum SelectMode{ GRID= -1, HORIZONTAL= 0, VERTICAL= 1 }

@export var container: Control
@export var items_id: Array[int]
@export var select_mode: SelectMode= SelectMode.VERTICAL
@export var horizontal_item_count: int= 0
@export var end_action: EndAction

var _items_in_tree= []
var _select: ListSelect
var _select_index= 0

func _ready():
    render()


func render():
    for i in _items_in_tree:
        i.queue_free()
    
    _items_in_tree= []
    if is_instance_valid(_select):
        _select.queue_free()

    _before_render(_items_in_tree)

    for i in items_id:
        var view= await _get_item(i)
        _items_in_tree.push_back(view)
        container.add_child(view)

    _setup_selection(_items_in_tree)
    _after_render(_items_in_tree)


func _setup_selection(nodes):
    _select= ListSelect.new(self, nodes, _select_index, select_mode)
    _select.horizontal_item_count= horizontal_item_count
    _select.effect_active= _effect_active
    _select.effect_blur= _effect_blur
    _select.on_select_end= _process_select_end
    _select.bind_index(self, "_select_index")


func _process_select_end(selected, all_nodes):
    match end_action:
        EndAction.DO_NOTHING:
            pass
        EndAction.DELETE:
            var new_ids= items_id.duplicate()
            new_ids.pop_at(_select.get_current_index())
            items_id= new_ids
            render()

    _select_end.call_deferred(selected, _select_index)


# @virtual
func _select_end(node, id):
    pass


# @virtual
func _effect_active(node):
    pass


# @virtual
func _effect_blur(node):
    pass


# @virtual
func _before_render(items_in_tree):
    pass


# @virtual
func _get_item(id) -> Control:
    return null


# @virtual
func _after_render(items_in_tree):
    pass
