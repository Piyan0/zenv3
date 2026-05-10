class_name EventPage
extends Resource

const EMPTY= "empty"

enum EventCommandsID{
    Commands_001 = 1, Commands_002, Commands_003, Commands_004,
    Commands_005, Commands_007, Commands_008, Commands_009,
    Commands_010, Commands_011, Commands_012, Commands_013,
    Commands_014, Commands_015, Commands_016, Commands_017,
    Commands_018, Commands_019, Commands_020,
}
enum Trigger{ PLAYER_TOUCH, INTERACT_BUTTON, AUTORUN }
enum InternalSwitch { NONE, A = 1, B = 2, C = 3, D = 4}
enum Placement { BELOW_GROUND=1, GROUND, ABOVE_GROUND }

@export var event_commands_id : EventCommandsID = EventCommandsID.Commands_001
@export var graphic: Texture2D
@export var graphic_offset= Vector2.ZERO

@export_group("animations")
@export var walk_animations: WalkAnimationCollection
@export var idle_animations: IdleAnimationCollection
@export_group("")

@export var trigger: Trigger= Trigger.INTERACT_BUTTON
@export var placement: Placement= Placement.GROUND
@export var through = false
# activations
@export var i_switch: InternalSwitch

@export var variable: String= EMPTY
@export var variable_value: int= -1

@export var global_switch_001: String= EMPTY
@export var global_switch_001_value: bool

@export var global_switch_002: String= EMPTY
@export var global_switch_002_value: bool

@export var event_traits: Array[EventTrait]
@export var static_command_list: Array[StaticEventCommand]
var event_commands: Callable


func exec_commands() -> void:
    for static_command in static_command_list:
        await static_command.run_command()
    
    await event_commands.call()


func is_event_active(
        internal_switches,
        variables,
        global_switches,
        ):
    # print(global_switches)
    var conditions= [
        _internal_switch_pass(internal_switches),
        _variable_pass(variables),
        _switch_pass(global_switch_001, global_switch_001_value, global_switches),
        _switch_pass(global_switch_002, global_switch_002_value, global_switches),
    ]
    for i in conditions:
        if i == false:
            return false
    
    return true
    

func _internal_switch_pass(switches):
    assert(!switches.is_empty(), str(switches))
    if i_switch == InternalSwitch.NONE: return true
    # printt(switches, i_switch)
    return switches[str(i_switch)] == true


func _variable_pass(variables):
    if variable == EMPTY: return true
    return variables[variable] == variable_value


func _switch_pass(switch_name, switch_value, switches):
    if switch_name == EMPTY: return true
    return switches[switch_name] == switch_value
