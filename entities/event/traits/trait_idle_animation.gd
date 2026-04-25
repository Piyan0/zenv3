class_name TraitIdleAnimation
extends EventTrait


@export var always_on= false
@export var animation_data: AnimationData

var _animation_process: AnimationProcess


func _enter(event):
    var anim= AnimationProcess.new()
    anim.target= event.spr
    _animation_process= anim
    event.add_child.call_deferred(anim)
    anim.animation_data= animation_data


func _exit(event):
    _animation_process.queue_free()


func _update(_delta, event: Event):
    if event.is_interact_running:
        if always_on:
            return
        _animation_process.pause= true
    else:
        _animation_process.pause= false 
    
