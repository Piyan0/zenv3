class_name EventPage
extends Resource

const EMPTY= "empty"

enum Trigger{ PLAYER_TOUCH, INTERACT_BUTTON, AUTORUN }
enum InternalSwitch { NONE, A, B, C, D }
enum Placement { BELOW_GROUND, GROUND, ABOVE_GROUND }

@export var graphic: Texture2D

@export var trigger: Trigger= Trigger.INTERACT_BUTTON
@export var placement: Placement= Placement.GROUND

# activations
@export var i_switch: InternalSwitch

@export var variable: String= EMPTY
@export var variable_value: int= -1

@export var global_switch_001: String= EMPTY
@export var global_switch_001_value: bool

@export var global_switch_002: String= EMPTY
@export var global_switch_002_value: bool

@export var event_commands_source: Script
@export var event_traits: Array[EventTrait]


func get_commands() -> EventCommands:
    if event_commands_source == null:
        return EventCommands.new()
    return event_commands_source.new()


func is_event_active(
        internal_switches: Dictionary,
        variables: Dictionary,
        global_switches: Dictionary,
        ):
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
    if i_switch == InternalSwitch.NONE: return true
    return switches[i_switch] == true


func _variable_pass(variables):
    if variable == EMPTY: return true
    return variables[variable] == variable_value


func _switch_pass(switch_name, switch_value, switches):
    if switch_name == EMPTY: return true
    return switches[switch_name] == switch_value
