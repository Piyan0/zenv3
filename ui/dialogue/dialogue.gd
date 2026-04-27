extends CanvasLayer

@export var bg: Control
@export var container: Control
@export var lb_name: Label
@export var lb_msg: Label
var _dialogue_base: DialogueBase

func _ready() -> void:
    # var x= await AnimateOpenCenter.spawn(bg, 0.4, func(): container.hide(), func(): container.show())
    _dialogue_base= DialogueBase.new() 
    _dialogue_base.on_progress= func(d, v, j):
        lb_name.text= d.speaker
        lb_msg.text= d.msg
        lb_msg.visible_characters= v
    
    _dialogue_base.dialogue_batch= [
        DialogueBase.DialogueNormal.new("piyan", "Anjay mabar..."),
        DialogueBase.DialogueNormal.new("salwa", "keren...."),
    ]

func _input(event: InputEvent):
    _dialogue_base.input(event)
    
    
func _start_dialogue():
    pass
    
