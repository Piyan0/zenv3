class_name MobileControl
extends CanvasLayer
signal on_hamburger_clicked()

@export var img_button_enable: Texture2D 
@export var img_button_disabled: Texture2D 
@export var btn_toggle_control: TouchScreenButton
@export var btn_hamburger: TouchScreenButton

@export var dpad_container: Node2D
@export var action_btn_contaienr: Node2D

var _is_control_enabled = true

func _ready():
    btn_hamburger.pressed.connect(func():
        on_hamburger_clicked.emit()    
    )
    
    btn_toggle_control.pressed.connect(func():
        _is_control_enabled = !_is_control_enabled    
        if _is_control_enabled:
            dpad_container.show()
            action_btn_contaienr.show()
        else:
            dpad_container.hide()
            action_btn_contaienr.hide()
    )


static func spawn():
    if OS.get_name() == "Android" or OS.get_name() == "iOS":
        var instance = load("uid://bxxlmvxb1njx0").instantiate()
        return instance
    return null
