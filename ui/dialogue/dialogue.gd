extends CanvasLayer

signal dialogue_finished()

@export var bg: Control
@export var container: Control
@export var lb_name: Label
@export var lb_msg: Label
@export var next_indicator: Control

var _dialogue_base: DialogueBase
var dialogue_batch: Array[DialogueBase.DialogueNormal]= [ DialogueBase.DialogueNormal.new("piyan", "kereen") ]

func _ready() -> void:
    lb_msg.text = ""
    lb_name.text = ""
    # var x= await AnimateOpenCenter.spawn(bg, 0.4, func(): container.hide(), func(): container.show())
    _dialogue_base= DialogueBase.new() 
    _dialogue_base.on_progress= func(d, v, j):
        next_indicator.hide()
        lb_name.text= d.speaker
        lb_msg.text= d.msg
        lb_msg.visible_characters= v
    _dialogue_base.line_finished.connect(func():
        next_indicator.show()
    )
    _dialogue_base.batch_finished.connect(func():
        dialogue_finished.emit()
        queue_free()    
    )
   
    _dialogue_base.dialogue_batch= dialogue_batch

func _input(event: InputEvent):
    _dialogue_base.input(event)
    
    
func _start_dialogue():
    pass
    
