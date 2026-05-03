extends VBoxContainer

signal selection_change(item)

@export var arrow_up: Control
@export var arrow_down: Control

var _select: ListSelect
var _select_index = 0
var _items_view_added = []
var _page: Pagination


func _ready() -> void:
    _items_view_added = get_children()
    _clear_items()
    owner.set_meta("_render_items", _render_items)


func _before_render():
    pass


func _after_render():
    _page = Pagination.new(self, _items_view_added, 4)
    _page.on_page_changed.connect(func():
        if _page.has_more_page_down():
            arrow_down.show()
        else:
            arrow_down.hide()
        
        if _page.has_more_page_up():
            arrow_up.show()
        else:
            arrow_up.hide()
    )

    _select = ListSelect.new(self, _items_view_added, _select_index, VERTICAL)
    _select.on_select_change = func(s, a):
        _page.update_page(_select.get_current_index())
        selection_change.emit(s.get_meta("item"))


func _render_items(items: Array):
    _before_render()
    _items_view_added= []
    for i in items:
        var item_view = load("uid://ci8j8b57p3nvg").instantiate()
        item_view.icon = i.get_icon()
        item_view.description = i.description
        item_view.item_name = i.name
        item_view.set_meta("item", i)
        _items_view_added.push_back(item_view)
        add_child(item_view)
    
    _after_render()


func _clear_items():
    for i in _items_view_added:
        i.queue_free()
