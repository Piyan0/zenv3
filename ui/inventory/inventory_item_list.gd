extends VBoxContainer

signal selection_change(item, select_index)
signal item_selected(item)

@export var arrow_up: Control
@export var arrow_down: Control

var _select: ListSelect
var select_index = 0
var _items_view_added = []
var _page: Pagination


func _ready() -> void:
    arrow_up.modulate.a = 0
    arrow_down.modulate.a = 0
    _items_view_added = get_children()
    _clear_items()


func render_items(items: Array):
    _before_render()
    _items_view_added= []
    var idx = 1
    for i in items:
        var item_view = load("uid://ci8j8b57p3nvg").instantiate()
        item_view.description = i.description
        item_view.item_name = i.name
        item_view.set_meta("item", i)
        item_view.set_index(idx)
        _items_view_added.push_back(item_view)
        add_child(item_view)
        idx += 1
    
    _after_render()

    
func _before_render():
    if is_instance_valid(_select):
        _select.queue_free()
    if is_instance_valid(_page):
        _page.queue_free()
    for i in get_children():
        i.queue_free()


func _after_render():
    _page = Pagination.new(self, _items_view_added, 4)
    _page.on_page_changed.connect(func():
        if _page.has_more_page_down():
            arrow_down.modulate.a = 1
        else:
            arrow_down.modulate.a = 0
        
        if _page.has_more_page_up():
            arrow_up.modulate.a = 1
        else:
            arrow_up.modulate.a = 0
    )

    _select = ListSelect.new(self, _items_view_added, select_index, VERTICAL)
    _select.on_select_end = func(s, a):
        _select.set_pause(true)
        var item = s.get_meta("item")
        await item.effect.call()
        _select.set_pause(false)
        item_selected.emit(item, _select.get_current_index())
    _select.on_select_change = func(s, a):
        _page.update_page(_select.get_current_index())
        selection_change.emit(s.get_meta("item"))


func _clear_items():
    for i in _items_view_added:
        i.queue_free()
