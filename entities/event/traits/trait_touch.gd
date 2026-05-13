class_name TraitTouch
extends EventTrait

# the different with event.player_touch is this always emitted whenever
# event area is touched by player.

# TODO it should be using static command of the event.
@export var static_commands: Array[StaticEventCommand]
@export var touch_min_distance = 1
var _is_running_event = false
func _update(delta, event):
    if !Player.instance: return
    var distance_from_player = Player.instance.position.distance_to(event.position)
    if distance_from_player <= touch_min_distance:
        if !_is_running_event:
            _is_running_event = true
            for i in static_commands:
                await i.run_command()
            _is_running_event = false
            
