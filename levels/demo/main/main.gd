extends Node2D

@export var x: Array[Control]

class X:
    var y= 1
    
func _ready() -> void:
    var u: X= X.new()
    print(u.y)
    var select= await ListSelect.new(self, x, 0, VERTICAL)
    select.horizontal_item_count= 2
    select.on_select_change= func(s, a):
        for i in a:
            i = i as Control
            i.modulate.a= 0.5
        s.modulate.a= 1
    
    select.on_select_end= func(s, a):
        print(s)
 
