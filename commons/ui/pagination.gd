class_name Pagination

var max_item_per_page= 2

var _item_index= -1
var _pages= []

func _init(p_owner):
    p_owner.add_child.call_deferred(self)


func update_page(idx):
    var page= _get_page(idx)
    for i in _pages:
        i.hide()
    for i in page:
        i.show()

func _get_page(idx):
    return int(floor(idx/_max_item_per_page))