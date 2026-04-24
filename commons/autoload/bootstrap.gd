extends Node


var event_manager


func _enter_tree():
    event_manager= EventManager.new()
    add_child(event_manager)
    
    add_canvas()
    MobileControl.new(self, true)
    
    await get_tree().process_frame
    event_manager.refresh_map()


func add_canvas():
    var cv= CanvasLayer.new()
    add_child(cv)
