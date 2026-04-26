extends Node

var event_manager
var asset_database
var progression

func _enter_tree():
    MobileControl.new(self, true)
    _add_canvas()
    
    event_manager= EventManager.new()
    add_child(event_manager)

    asset_database= AssetDatabase.new("res://vault/asset_database")
    
    progression= _load_progression()
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


func _load_progression():
    var progression= Progression.new("res://vault/progression/variables.cfg", "res://vault/progression/global_switches.cfg")
    return progression
    
    
func _add_canvas():
    var cv= CanvasLayer.new()
    add_child(cv)
