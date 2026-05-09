class_name TraitLookAtInteract
extends EventTrait

@export var back_to_graphic= true
var _is_on_interact= false

func _enter(event):
    pass
    

func _exit(event):
    pass


func _update(delta, event):
    if event.is_interact_running:
        if _is_on_interact: return
        _is_on_interact= true
        event.play_animation(_get_dir(event.interact_direction))
        _is_on_interact= false
        # TODO implement this.
        # if back_to_graphic:
        #     event.reset_texture()

  
func _get_dir(dir):
    match dir:
        Vector2.UP:
            return "idle_up"
        Vector2.DOWN:
            return "idle_down"
        Vector2.LEFT:
            return "idle_left"
        Vector2.RIGHT:
            return "idle_right"
