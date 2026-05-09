extends CanvasLayer
class_name NaratorView
signal finished()

@export var lb_msg: Label
@export var tr_bg: TextureRect

var _dialogue_base: DialogueBase
var _example_long_msg = "So this is a very long message, it might takes about two lines, in order to test for the...I don't know."
var _example_short_msg = "message."
var _current_bg_id = ""
var narator_dialogue = null
func _ready() -> void:
	tr_bg.hide()
	_dialogue_base = DialogueBase.new()
	_dialogue_base.batch_finished.connect(func():
		finished.emit()
		queue_free()
	)
	_dialogue_base.on_progress = func(dialogue: NaratorDialogue, visible_characters, just_changed):
		if just_changed:
			_change_bg(dialogue.bg_id, dialogue.get_bg())
			
		lb_msg.text = dialogue.msg
		lb_msg.visible_characters = visible_characters
	#print(narator_dialogue)
	_dialogue_base.dialogue_batch = narator_dialogue
	

func _input(event: InputEvent) -> void:
	_dialogue_base.input(event)
	

func _change_bg(new_bg_id, img):
	if img == null:
		return
		
	if new_bg_id != _current_bg_id && tr_bg.visible:
		await _close_image()
	tr_bg.show()
	await _show_image(img)
	_current_bg_id = new_bg_id
	

func _show_image(img):
	tr_bg.texture = img
	var fade = AnimateFade.new(tr_bg, true, 0.5)
	await fade.finished
	

func _close_image():
	var fade = AnimateFade.new(tr_bg, false, 0.5)
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
