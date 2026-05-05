class_name EventManager
extends Node

signal map_refreshed(events)

var can_process_interact = func(): return true
var _current_input: InputEvent= InputEventAction.new()
var _is_running_event= false


func _init(p_owner):
    p_owner.add_child(self)
    name= "EventManager"
    
    
func _input(event):
    if !can_process_interact.call():
        return
    if event is InputEventAction || event is InputEventKey:
        _current_input= event


func _process(_delta):
    var events_in_area= get_tree().get_nodes_in_group("events")
    for i in events_in_area:
        if _is_running_event: break
        var player= Player.instance
        # Don't process further if player hasn't been instantiated.
        if !player || _current_input == null: return
        if i.is_interact(player, _current_input):
            # print(1)
            _is_running_event= true
            player.lock_counter += 1
            await i.interact(player)
            await _delay_after_interact()
            _is_running_event= false
            player.lock_counter -= 1
            _current_input = null


func refresh_map(internal_switches, variables, global_switches):
    var events= get_tree().get_nodes_in_group("events")
    for i in events:
        i.update_active_event(internal_switches, variables, global_switches)
    
    map_refreshed.emit(events)


func get_event(id: String):
    for i in get_tree().get_nodes_in_group("events"):
        if i.name == id:
            return i
    assert(false, "No event with 'id' of '{0}' in the current scene.".format([id]))
    return null


func _delay_after_interact():
    await get_tree().create_timer(0.33).timeout
