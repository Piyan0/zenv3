class_name PlayerAnimationCollection
extends Resource
const EMPTY = "[empty]"

@export var switch = EMPTY
@export var idle_animations: IdleAnimationCollection
@export var walk_animations: WalkAnimationCollection


func is_active(global_switches):
    if switch == EMPTY:
        return true
    return global_switches[switch]
