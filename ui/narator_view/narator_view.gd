extends CanvasLayer

enum Position{TOP, CENTER, BOTTOM_RIGHT}

# TODO implement background.

@export var lb_top: Label
@export var lb_bottom_right: Label
@export var lb_center: Label

@onready var _labels = [lb_top, lb_bottom_right, lb_center]
@onready var _dialogue_pos_mapping = {
    Position.TOP : lb_top,
    Position.CENTER : lb_center,
    Position.BOTTOM_RIGHT : lb_bottom_right,
}

var _dialogue_base: DialogueBase
var _label_used: Label

func _ready() -> void:
    _dialogue_base = DialogueBase.new()
    _dialogue_base.on_progress = func(dialogue: NaratorDialogue, visible_characters, just_changed):
        if just_changed:
            _hide_labels()
            _label_used = _dialogue_pos_mapping[dialogue.position]
            _label_used.show()
        
        _label_used.text = dialogue.msg
        _label_used.visible_characters = visible_characters

     
    _dialogue_base.dialogue_batch = [
        NaratorDialogue.new("test messsage", Position.TOP),
        NaratorDialogue.new("another message another message another message another message", Position.CENTER),
        NaratorDialogue.new("a message.", Position.BOTTOM_RIGHT),
        NaratorDialogue.new("another message another message another message another message", Position.TOP),
    ]
        


func _input(event: InputEvent) -> void:
    _dialogue_base.input(event)



func _hide_labels():
    for i in _labels:
        i.hide()

    
class NaratorDialogue:
    extends DialogueBase.DialogueNormal

    var position: Position = Position.TOP

    func _init(p_msg, p_pos):
        msg = p_msg
        position = p_pos
