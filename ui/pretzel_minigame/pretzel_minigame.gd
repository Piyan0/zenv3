@tool
extends CanvasLayer

signal game_over()
signal player_changed(id)


@export var game_over_text: TextureRect
@export var player_01_avatar: TextureRect
@export var player_02_avatar: TextureRect
@export var health_container: Control
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

var _active_player = -1
var _active_hit_spot 
var _health

func _ready() -> void:
    if Engine.is_editor_hint(): return 
    _setup()
    # game_over.connect(func():
    #     var eva = EventPageActions.new()
    #     eva.push(["goto", "map_level_01_01", 0,0, "down", true])
    # )


func _setup():
    for i in health_container.get_children():
        i.show()
    hit_state = 0
    _health = health_container.get_children() 
    _active_hit_spot =_sync_hit_spot()
    _toggle_player()


func _unhandled_input(event: InputEvent) -> void:
    if !_can_hit(): return
    if event.is_action_pressed("ui_accept"):
        _try_hit()


static func spawn():
    var ins = load("uid://bathporo7b0oe").instantiate()
    Bootstrap.canvas.add_child(ins)
    await ins.game_over
    

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
    else:
        _health.pop_back().hide()
    
    _toggle_player()
    if !_can_hit():
        if _health.is_empty():
            game_over_text.show()
            var choice = await Choice.spawn(Vector2(160, 96), ["ui_retry", "ui_close"] as Array[String], true)
            if choice == 0:
                game_over_text.hide()
                _setup()
                return
        await get_tree().create_timer(1).timeout
        var fade = await TransitionBlack.spawn()     
        queue_free()
        tree_exited.connect(func():
            fade.confirm()
            game_over.emit()
        ,CONNECT_ONE_SHOT)


func _is_game_over():
    if _health.is_empty():
        return true
    return false


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
    return hit_state <= hit_spot_list.size() - 1 && !_is_game_over()


func _toggle_player():
    _active_player = (_active_player + 1) % 2
    player_01_avatar.modulate = Color("#656565")
    player_02_avatar.modulate = Color("#656565")
    
    if _active_player == 0:
        player_01_avatar.modulate = Color.WHITE
    else:
        player_02_avatar.modulate = Color.WHITE
    
    #print(_active_player)
    player_changed.emit(_active_player)
        
