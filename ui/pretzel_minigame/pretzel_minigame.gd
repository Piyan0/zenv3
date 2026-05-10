@tool
extends CanvasLayer

@export var mark: Node2D
@export var hit_spot_list: Array[Node2D]
@export var img_pretzel_state_list: Array[Texture2D]
@export var img_pretzel_flash: Texture2D
@export var spr_hit_state: Sprite2D
@export var hit_state = 0:
    set(value):
        hit_state = min(value, img_pretzel_state_list.size() - 1)
        if !is_inside_tree():
            await ready

        _sync_hit_state()

var _active_hit_spot 

func _ready() -> void:
    if Engine.is_editor_hint(): return 
    _active_hit_spot =_sync_hit_spot()


func _unhandled_input(event: InputEvent) -> void:
    if !_can_hit(): return
    if event.is_action_pressed("ui_accept"):
        _try_hit()


func _try_hit():
    var is_hit = mark.is_hit(_active_hit_spot.get_rect())
    if is_hit:
        hit_state += 1
        _shake()
        spr_hit_state.texture = img_pretzel_flash
        Engine.time_scale = 0
        await get_tree().create_timer(0.05, true, false, true).timeout
        _sync_hit_state()
        _active_hit_spot = _sync_hit_spot()
        if _active_hit_spot:
            _active_hit_spot.flash()
        Engine.time_scale = 1


func _shake():
    var t = create_tween()
    var default_pos = spr_hit_state.position
    t.tween_property(spr_hit_state ,"position", spr_hit_state.position + Vector2.UP, 0.1)
    t.tween_property(spr_hit_state ,"position", spr_hit_state.position + Vector2.DOWN, 0.1)
    t.tween_property(spr_hit_state ,"position", spr_hit_state.position + Vector2.RIGHT, 0.1)
    t.tween_property(spr_hit_state ,"position", default_pos, 0.1)


func _sync_hit_state():
    if hit_state > img_pretzel_state_list.size() - 1:
        return

    var img = img_pretzel_state_list[hit_state]
    spr_hit_state.texture = img


func _sync_hit_spot():
    for i in hit_spot_list:
        i.hide()
    if hit_state > hit_spot_list.size() - 1:
        return
    var spot = hit_spot_list[hit_state]
    spot.show()
    mark.move_mark(spot.position)
    return spot


func _can_hit():
    return hit_state <= hit_spot_list.size() - 1
