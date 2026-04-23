extends Node


func _enter_tree():
    add_canvas()
    MobileControl.new(self, true)

func add_canvas():
    var cv= CanvasLayer.new()
    add_child(cv)