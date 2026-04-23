extends Node2D

@export var x: Array[Control]

func _ready() -> void:
    var page= Pagination.new(self, x, 3)
 
    var select= await ListSelect.new(self, x, 5, VERTICAL)
    select.horizontal_item_count= 2

    select.on_select_change= func(s, a):
        for i in a:
            i = i as Control
            i.modulate.a= 0.5
        s.modulate.a= 1
        page.update_page(select.get_current_index())
    
    select.on_select_end= func(s, a):
        print(s)
 
