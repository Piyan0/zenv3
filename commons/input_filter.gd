class_name InputFilter
extends Node

var allow_input = func(input_ev: InputEvent): return true
var is_multiplayer = false
var player1_device = -1
var player2_device = -1
var _input_cb = {}


func _ready() -> void:
    _input_cb["player_1"] = func(event: InputEvent):
        if event.device != player1_device:
            return false
        return true

    _input_cb["player_2"] = func(event: InputEvent):
        if event.device != player2_device:
            return false
        return true

func _input(ev):
    if !allow_input.call(ev):
        get_viewport().set_input_as_handled()


func set_allow_input(id):
    allow_input = _input_cb[id]

        
