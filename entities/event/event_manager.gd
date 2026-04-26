class_name EventManager
extends Node

var _current_input: InputEvent= InputEventAction.new()
var _is_running_event= false

var _internal_switches: Dictionary[String, Dictionary]= {}
var _global_switches: Dictionary[String, bool]= {}
var _variables: Dictionary[String, int]= {}

func _input(event):
    if event is InputEventAction || event is InputEventKey:
        _current_input= event


func _process(_delta):
    var events_in_area= get_tree().get_nodes_in_group("events")
    for i in events_in_area:
        if _is_running_event: break
        var player= Player.instance
        if i.is_interact(player, _current_input):
            _is_running_event= true
            player.lock_input= true
            await i.interact(player)
            await _delay_after_interact()
            _is_running_event= false
            player.lock_input= false


func refresh_map():
    var events= get_tree().get_nodes_in_group("events")
    for i in events:
        i.update_active_event(_internal_switches, _variables, _global_switches)
        var current_sceene= get_tree().current_scene
        if current_sceene is Map:
            var map_id= current_sceene.map_id
            _add_internal_switch(str(map_id)+"-"+i.name)
    #print(_internal_switches)
    #print(get_event("ev000"))


func get_event(id: String):
    for i in get_tree().get_nodes_in_group("events"):
        if i.name == id:
            return i
    assert(false, "No event with 'id' of '{0}' in the current scene.".format([id]))
    return null


func _add_internal_switch(id):
    if id in _internal_switches: return
    _internal_switches[id]= {
        EventPage.InternalSwitch.A: false,
        EventPage.InternalSwitch.B: false,
        EventPage.InternalSwitch.C: false,
        EventPage.InternalSwitch.D: false,
    }
    

func _delay_after_interact():
    await get_tree().create_timer(0.2).timeout
