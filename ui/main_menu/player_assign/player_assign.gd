extends Control

signal mapping_finished(data)

@export var player1_avatar: Control
@export var player2_avatar: Control
@export var lb_hint: Label
@export var img_controller_flash: Texture2D
@export var tr_controller: TextureRect

var _input_queue = ["player_1", "player_2"]
var _joy_mapping_result = {}


func _ready() -> void:
    player1_avatar.modulate = Color.DARK_GRAY
    player2_avatar.modulate = Color.DARK_GRAY


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        mapping_finished.emit(null)
        queue_free()


    if event is InputEventJoypadButton:
        if event.device in _joy_mapping_result.values():
            print("device {0} already mapped.".format([event.device]))
            return

        if event.button_index == JOY_BUTTON_START && event.pressed:
            var player_id = _input_queue.pop_front()
            _handle_start_pressed(player_id)
            _joy_mapping_result[player_id] = event.device

    if _input_queue.is_empty() && event.is_pressed():
        mapping_finished.emit(_joy_mapping_result)
        queue_free()
        return

func _handle_start_pressed(player_id):
    var default_texture = tr_controller.texture

    match player_id:
        "player_1":
            lb_hint.text = "ui_press_start_2p"
            player1_avatar.modulate = Color.WHITE
        "player_2":
            player2_avatar.modulate = Color.WHITE
    
    var t = create_tween()
    t.tween_callback(func():
        tr_controller.texture = img_controller_flash    
    )
    t.tween_interval(0.2)
    t.tween_callback(func():
        tr_controller.texture = default_texture    
    )
