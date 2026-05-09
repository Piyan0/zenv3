extends Control

signal changed(idx)

@export var _img_state_01: Texture2D
@export var _img_state_02: Texture2D
@export var _img_state_03: Texture2D
@export var _img_state_04: Texture2D
@export var _img_state_05: Texture2D
@export var _tr_main: TextureRect
@export var _tr_hand_pointer: TextureRect

var _state_map = {}
var _current_index = 0

func _ready() -> void:
    _state_map[0] = _img_state_01
    _state_map[1] = _img_state_02
    _state_map[2] = _img_state_03
    _state_map[3] = _img_state_04
    _state_map[4] = _img_state_05


func state_active():
    _tr_hand_pointer.show()
    

func state_blur():
    _tr_hand_pointer.hide()
    
    
func up():
    _current_index = (_current_index + 1 + _state_map.size()) % _state_map.size() 
    _tr_main.texture = _state_map[_current_index]
    changed.emit(_current_index)


func get_value():
    return _current_index
