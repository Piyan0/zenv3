class_name SokobanSource
extends Node

@export var box_list: Node2D
@export var destination_list: Node2D
@export var allowed_routes: Node2D
@export var switch = ""
@export var switch_value = false

func _ready() -> void:
    for i in box_list.get_children():
        i.box_pushed.connect(_evaluate_puzzle)
        i.routes.assign(allowed_routes.get_children())


func _evaluate_puzzle():
    var is_correct = await _is_all_box_placed()
    # print(is_correct)
    if is_correct:
        if !switch.is_empty():
            Bootstrap.progression.set_switch(switch, switch_value)


func _is_all_box_placed():
    for i in destination_list.get_children():
        var box_exists = await i.box_exists()
        if !box_exists:
            return false
    
    return true
