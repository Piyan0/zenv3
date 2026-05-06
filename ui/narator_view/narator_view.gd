extends CanvasLayer

@export var lb_msg: Label
@export var tr_bg: TextureRect

var _dialogue_base: DialogueBase
var _example_long_msg = "So this is a very long message, it might takes about two lines, in order to test for the...I don't know."
var _example_short_msg = "message."
var _current_bg_id = ""

func _ready() -> void:
    _dialogue_base = DialogueBase.new()
    _dialogue_base.on_progress = func(dialogue: NaratorDialogue, visible_characters, just_changed):
        if just_changed:
           # print(1)
            var bg = dialogue.get_bg()
            if bg!= null:
                if dialogue.bg_id != _current_bg_id:
                    _current_bg_id = dialogue.bg_id
                    await _close_image()
                print(2)
                _show_image(bg)
                
        lb_msg.text = dialogue.msg
        lb_msg.visible_characters = visible_characters
     
    _dialogue_base.dialogue_batch = [  
        NaratorDialogue.new(_example_short_msg),
        NaratorDialogue.new(_example_long_msg, "img_screen"),
        NaratorDialogue.new(_example_short_msg, "img_screen_transparent"),
        NaratorDialogue.new(_example_long_msg, "img_screen"),
    ]
        

func _input(event: InputEvent) -> void:
    _dialogue_base.input(event)
    

func _show_image(img):
    tr_bg.texture = img
    var fade = AnimateFade.new(tr_bg, true, 0.5)
    await fade.finished
    

func _close_image():
    var fade = AnimateFade.new(tr_bg, true, 0.5)
    await fade.finished
    
    
class NaratorDialogue:
    extends DialogueBase.DialogueNormal
    var bg_id = ""
    
    func _init(p_msg, p_bg_id = ""):
        msg = p_msg
        bg_id = p_bg_id
    
    func get_bg():
        if bg_id.is_empty(): return null
        return Bootstrap.asset_loader.get_asset(bg_id)
