extends CanvasLayer

enum Position{TOP, CENTER, BOTTOM_RIGHT}

# TODO implement background.

@export var lb_top: Label
@export var lb_bottom_right: Label
@export var lb_center: Label

@onready var _dialogue_pos_mapping = {
    Position.TOP : lb_top,
    Position.CENTER : lb_center,
    Position.BOTTOM_RIGHT : lb_bottom_right,
}

var _label_min_size= {}
var _dialogue_base: DialogueBase
var _label_used: Label

var _example_long_msg = "So this is a very long message, it might takes about two lines, in order to test for the...I don't know."
var _example_short_msg = "message."

func _ready() -> void:
    for i in _dialogue_pos_mapping.keys():
        _label_min_size[i] = _dialogue_pos_mapping[i].custom_minimum_size
        
    _dialogue_base = DialogueBase.new()
    _dialogue_base.on_progress = func(dialogue: NaratorDialogue, visible_characters, just_changed):
        if just_changed:
            _hide_labels()
            _label_used = _dialogue_pos_mapping[dialogue.position]
            var oneline_size = _oneline_size(_label_used, dialogue.msg)
            if oneline_size.x < _label_min_size[dialogue.position].x:
                _label_used.custom_minimum_size = oneline_size
            _label_used.show()
        
        _label_used.text = dialogue.msg
        _label_used.visible_characters = visible_characters

     
    _dialogue_base.dialogue_batch = [  
        NaratorDialogue.new(_example_short_msg, Position.BOTTOM_RIGHT),
        NaratorDialogue.new(_example_long_msg, Position.CENTER),
        NaratorDialogue.new(_example_short_msg, Position.TOP),
    ]
        


func _input(event: InputEvent) -> void:
    _dialogue_base.input(event)



func _hide_labels():
    for i in _dialogue_pos_mapping.keys():
        var lb = _dialogue_pos_mapping[i]
        lb.hide()
        lb.custom_minimum_size = _label_min_size[i]


func _oneline_size(p_lb: Label, text: String):
    var lb = p_lb.duplicate()
    lb.custom_minimum_size = Vector2.ZERO
    lb.autowrap_mode = TextServer.AutowrapMode.AUTOWRAP_OFF
    lb.text = text
    add_child(lb)
    #lb.text = text
    return lb.size
    
    
class NaratorDialogue:
    extends DialogueBase.DialogueNormal

    var position: Position = Position.TOP

    func _init(p_msg, p_pos):
        msg = p_msg
        position = p_pos
