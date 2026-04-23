extends Node2D

@export var x: Array[Control]
@export var lb: Label
@export var c: Control

var dialogue

func _ready() -> void:
    dialogue= DialogueBase.new()
    dialogue.on_progress= func(d, v, j):
        lb.text= d.msg
        lb.visible_characters= v
        
    dialogue.batch_finished.connect(func():
        lb.queue_free()
    )
    dialogue.dialogue_batch= [
        DialogueBase.DialogueNormal.new("piyan", "Salwa kamu cantik banget jir..."),
        DialogueBase.DialogueNormal.new("salwa", "wah yang bener kamu..."),
    ] as Array[DialogueBase.DialogueNormal]
    
    var f= AnimateFade.new(c, true)
    var xx= AnimateOffset.new(c, Vector2(0, -70), 10)
    await xx.finished
    var yy= AnimateOffset.new(c, Vector2(0, 70), 10)
    return
    var page= Pagination.new(self, x, 3)
 
    var select= await ListSelect.new(self, x, 5, VERTICAL)
    select.horizontal_item_count= 2

    select.on_select_change= func(s, a):
        for i in a:
            i = i as Control
            i.modulate.a= 0.5
        s.modulate.a= 1
        page.update_page(select.get_current_index())
    
    select.on_select_end= func(s, a):
        print(s)
 
 
func _input(event: InputEvent):
    dialogue.input(event)
