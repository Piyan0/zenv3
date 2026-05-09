class_name TextShadow
extends Node

@export var target: Label
@export var offset= Vector2(1,1)
@export var shadow_color= Color.BLACK
var clone

func _ready():
    # target.visibility_changed.connect(_setup)
    await get_tree().process_frame
    clone= target.duplicate()
    clone.set_script(null)
    target.add_child(clone)
    _setup()


func _setup():
    clone.self_modulate= Color.WHITE
    clone.modulate= shadow_color
    clone.show_behind_parent= true
    clone.z_as_relative = false
    clone.set_anchors_and_offsets_preset(Control.LayoutPreset.PRESET_FULL_RECT)
    clone.position= Vector2.ZERO + offset
    

func _process(_delta):
    if clone:
        # target.force_update_transform()
        # clone.force_update_transform()
        clone.visible = target.visible
        clone.visible_characters= target.visible_characters
        clone.text= target.text
        
    
