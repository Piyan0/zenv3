class_name HandPointer
extends HBoxContainer


@export var arrow: TextureRect
@export var lb_msg: Label
@export var msg: String= "msg_here"


func _ready():
    lb_msg.text= msg
    await get_tree().create_timer(1).timeout
    msg= "anjay"
    
    
func state_active():
    arrow.modulate.a= 1
    lb_msg.modulate.a= 1


func state_blur():
    arrow.modulate= 0
    lb_msg.modulate.a= 0.5
    
