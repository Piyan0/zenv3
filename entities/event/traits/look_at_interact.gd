class_name TraitLookAtInteract
extends EventTrait


@export var look_up: Texture2D
@export var look_down: Texture2D
@export var look_left: Texture2D
@export var look_right: Texture2D


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


func _update(delta, event):
    if event.is_interact_running:
        event.set_texture(_get_texture(event.interact_direction))
    else:
        event.set_texture(event.active_event_page.graphic)
        
