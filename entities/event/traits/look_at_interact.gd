class_name TraitLookAtInteract
extends EventTrait


@export var look_up: Texture2D
@export var look_down: Texture2D
@export var look_left: Texture2D
@export var look_right: Texture2D


var update= true
func _update(delta, event):
    if !update: return

    if event.is_interact_running:
        update= false
        var direction_texture= _get_texture(event.interact_direction)
        event.set_texture(direction_texture)
        await event.interact_finished
        update= true
        
  
        


func _get_texture(dir):
    match dir:
        Vector2.UP:
            return look_up
        Vector2.DOWN:
            return look_down
        Vector2.LEFT:
            return look_left
        Vector2.RIGHT:
            return look_right

