class_name TextShadow
extends Node

@export var target: Label
@export var offset= Vector2(1,1)
@export var shadow_color= Color.BLACK
var clone

func _ready():
    clone= target.duplicate()
    target.add_child.call_deferred(clone)
    clone.self_modulate= Color.WHITE
    clone.modulate= shadow_color
    clone.show_behind_parent= true
    clone.position= Vector2.ZERO + offset
    

func _process(_delta):
    if clone:
        clone.visible_characters= target.visible_characters
        clone.text= target.text
        
    
