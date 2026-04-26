extends Node


var event_manager
var asset_database

func _enter_tree():
    event_manager= EventManager.new()
    add_child(event_manager)
    
    add_canvas()
    MobileControl.new(self, true)
    asset_database= AssetDatabase.new("res://vault/asset_database")
    

func add_canvas():
    var cv= CanvasLayer.new()
    add_child(cv)
