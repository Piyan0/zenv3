class_name EventManager
extends Node

var _current_input: InputEvent= InputEventAction.new()
var _is_running_event= false

var _internal_switches: Dictionary[String, bool]= {}
var _global_switches: Dictionary[String, bool]= {}
var _variables: Dictionary[String, int]= {}


func refresh_map():
    var events= get_tree().get_nodes_in_group("events")
    for i in events:
        i.update_active_event(_internal_switches, _variables, _global_switches)
    

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


func _delay_after_interact():
    await get_tree().create_timer(0.2).timeout

func _input(event):
    if event is InputEventAction || event is InputEventKey:
        _current_input= event
