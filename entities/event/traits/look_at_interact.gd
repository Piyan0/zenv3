class_name TraitLookAtInteract
extends EventTrait

@export var trait_idle: TraitIdleAnimation
@export var back_to_graphic= true

var _anim_process: AnimationProcess
var _is_on_interact= false

func _enter(event):
    _anim_process= AnimationProcess.new()
    _anim_process.target= event.spr
    event.add_child.call_deferred(_anim_process)
    

func _exit(event):
    _anim_process.queue_free()


func _update(delta, event):
    if event.is_interact_running:
        if _is_on_interact: return
        _is_on_interact= true
        _anim_process.pause= false
        var animation_data= _get_texture(event.interact_direction)
        _anim_process.change_animation(animation_data)
        await event.interact_finished
        _anim_process.pause= true
        _is_on_interact= false
        if back_to_graphic:
            event.reset_texture()

  
func _get_texture(dir):
    match dir:
        Vector2.UP:
            return trait_idle.idle_up
        Vector2.DOWN:
            return trait_idle.idle_down
        Vector2.LEFT:
            return trait_idle.idle_left
        Vector2.RIGHT:
            return trait_idle.idle_right
