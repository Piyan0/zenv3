extends Control
signal text_pressed(text)

@export var btn: Button
@export var lb: Label
@export var highlight: Control

var _hovered = false
func _ready() -> void:
    btn.pressed.connect(func():
        text_pressed.emit(lb.text)   
    )


func emit_text_pressed():
    text_pressed.emit(lb.text)
    
    
func _process(_delta):
    if btn.is_hovered():
        state_active()
        _hovered= true
    else:
        if _hovered:
            state_blur()
            _hovered = false
        

func state_active():
    highlight.show()


func state_blur():
    highlight.hide()
    

func set_text(value):
    lb.text = value
