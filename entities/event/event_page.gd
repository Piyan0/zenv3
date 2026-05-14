class_name EventPage
extends Resource

const EMPTY= "empty"

enum Direction {UP, DOWN, LEFT, RIGHT}
enum Trigger{ PLAYER_TOUCH, INTERACT_BUTTON, AUTORUN }
enum InternalSwitch { NONE, A = 1, B = 2, C = 3, D = 4}
enum Placement { BELOW_GROUND=1, GROUND, ABOVE_GROUND }


# TODO add event graphic resources.
@export_group("graphics")
@export var graphic: Texture2D
@export var graphic_offset= Vector2.ZERO
@export_group("")

@export_group("animations")
@export var direction: Direction
@export var walk_animations: WalkAnimationCollection
@export var idle_animations: IdleAnimationCollection
@export_group("")

@export_group("conditions")
@export var trigger: Trigger= Trigger.INTERACT_BUTTON
@export var placement: Placement= Placement.GROUND
@export var through = false
@export var i_switch: InternalSwitch
# TODO add item conditions.
@export var variable: String= EMPTY
@export var variable_value: int= -1
@export var global_switch_001: String= EMPTY
@export var global_switch_002: String= EMPTY
@export var tags: String= "[implement this]"
@export_group("")

@export_group("debug")
@export var force_active = false
@export var force_disabled = false
@export_group("")

# TODO why we have to auto increment this...
@export var event_commands_id : int = 1
@export var event_traits: Array[EventTrait]
@export var static_command_list: Array[StaticEventCommand] = [null, null]
var event_commands: Callable


func exec_commands() -> void:
    for static_command in static_command_list:
        if static_command == null: continue
        await static_command.run_command()
    
    await event_commands.call()


func is_event_active(
        internal_switches,
        variables,
        global_switches,
        ):
    if OS.is_debug_build():
        if force_active:
            return true
        elif force_disabled:
            return false
            
    # print(global_switches)
    var conditions= [
        _internal_switch_pass(internal_switches),
        _variable_pass(variables),
        _switch_pass(global_switch_001, global_switches),
        _switch_pass(global_switch_002, global_switches),
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


func _switch_pass(switch_name, switches):
    if switch_name == EMPTY: return true
    return switches[switch_name] == true
