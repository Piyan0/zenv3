extends Node

var event_manager
var asset_database
var progression
var map_manager
var canvas
var items_database

func _enter_tree():
    MobileControl.new(self, true)
    canvas= _add_canvas()
    
    event_manager= EventManager.new(self)

    asset_database= AssetDatabase.new("res://vault/asset_database")
    
    progression= _boot_progression()
    progression.entries_changed.connect(func(it_switch, vars, gb_switch):
        event_manager.refresh_map(it_switch, vars, gb_switch)
        )
        
    #print(progression.get_data())
    event_manager.map_refreshed.connect(func(events):
        var current_scene= get_tree().current_scene
        if current_scene is Map:
            var map_id= current_scene.map_id
            for i in events:
                progression.add_internal_switch(str(map_id)+"-"+i.name)
        )
    
    map_manager= _boot_map_manager()
    
    items_database= ItemsDatabase.new()


func _boot_map_manager():
    var scene_man= MapManager.new(self, "res://entities/player/player.tscn")
    return scene_man


func _boot_progression():
    var progression= Progression.new("res://vault/progression/variables.cfg", "res://vault/progression/global_switches.cfg")
    return progression
    
    
func _add_canvas():
    var cv= CanvasLayer.new()
    # other canvas layer should below this, as global_canvas is considered as high priority draw order.
    cv.layer= 10
    cv.name= "GlobalCanvas"
    add_child(cv)
    return cv
