extends Control

@export var tr_liquid: TextureRect
@export var img_flash: Texture2D
@export var pointer: TextureRect
@export var lb_hint: Label

@export var img_state0: Texture2D
@export var img_state1: Texture2D
@export var img_state2: Texture2D
@export var img_state3: Texture2D
@onready var img_states = [img_state0, img_state1, img_state2, img_state3]

var value = -1

func _ready():
    up()


func up():
    var t = create_tween()
    t.tween_callback(func():
        tr_liquid.texture = img_flash
    )
    t.tween_interval(0.1)
    t.tween_callback(func():
        tr_liquid.texture = _get_next_texture()
        lb_hint.text = str(value)
    )
    await t.finished
    

func state_active():
    pointer.show()
    
    
func state_blur():
    pointer.hide()
    
    
func _get_next_texture():
    value = (value + 1) % 4
    return img_states[value]
