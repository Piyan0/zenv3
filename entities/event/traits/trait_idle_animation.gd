class_name TraitIdleAnimation
extends EventTrait

enum Direction {UP, DOWN, LEFT, RIGHT}
@export_group("Idle Animations")
@export var idle_up: AnimationData
@export var idle_down: AnimationData
@export var idle_left: AnimationData
@export var idle_right: AnimationData
@export_group("")

@export var always_on= false
@export var direction: Direction 

var _animation_data: AnimationData
var _animation_process: AnimationProcess

func _enter(event):
    var _idle_animations_map={
        Direction.UP: idle_up,
        Direction.DOWN: idle_down,
        Direction.LEFT: idle_left,
        Direction.RIGHT: idle_right,
    }
    _animation_data= _idle_animations_map[direction]
    var anim= AnimationProcess.new()
    anim.target= event.spr
    anim.change_animation(_animation_data)
    _animation_process= anim
    event.add_child.call_deferred(anim)


func _exit(event):
    _animation_process.queue_free()


func _update(_delta, event: Event):
    if event.is_interact_running:
        if always_on:
            return
        _animation_process.pause= true
    else:
        _animation_process.pause= false 
        

func get_animation_process():
    return _animation_process
