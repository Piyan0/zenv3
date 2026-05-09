extends Node2D
class_name StepArea

signal stepped(id)

@export var state_one: Texture2D
@export var state_two: Texture2D
@export var spr_step_graphic: Sprite2D
@export var id = 0
@export var step_area: Area2D
@export var icon: Texture2D
@export var hint: Label
var is_stepped = false

func _ready() -> void:
    hint.text = str(id)
    if !OS.is_debug_build():
        hint.hide()
    step_area.area_entered.connect(func(area):
        if is_stepped:
            return
        is_stepped = true
        stepped.emit(id)    
        spr_step_graphic.texture = state_two
    )


func reset():
    is_stepped = false
    spr_step_graphic.texture = state_one
    

func disable():
    spr_step_graphic.texture = state_two
