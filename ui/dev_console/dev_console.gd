class_name DevConsole
extends Control

@export var line_edit: LineEdit
@export var lb_msg: Label
@export var btn_console: Button
@export var btn_console_container: Control
@export var console_container: Control
@export var autocomplete_container: Control


var commands = [ConsoleCommand.new()]
var _is_console_visible = false

func _ready():
    #print(_remove_word_at_caret("anjay mabar", 6, "keren."))
    autocomplete_container.hide()
    autocomplete_container.selected.connect(
        func(text):
            var new_text = _remove_word_at_caret(line_edit.text, line_edit.caret_column, text)
            line_edit.text =  new_text
            if OS.get_name() == "Android":
                line_edit.release_focus()
                while  DisplayServer.virtual_keyboard_get_height() > 0:
                    await get_tree().process_frame
            
            line_edit.caret_column = new_text.length()
            line_edit.grab_focus()
    )
    
    btn_console.pressed.connect(
        func():
            _is_console_visible = !_is_console_visible
            if !_is_console_visible:
                autocomplete_container.off()
            _console_visible(_is_console_visible)
            await get_tree().create_timer(0.2).timeout
            btn_console.release_focus()
    )
    _console_visible(false)
    lb_msg.text = ""
    line_edit.text_submitted.connect(
        func(text):
            for i in commands:
                var valid = i.is_valid(text)
                if valid:
                    _show_msg(i.get_msg())
                    #line_edit.clear.call_deferred()
                    return
            _show_msg("Err. Command not exist")
    )
    
    line_edit.text_changed.connect(
        func(text):
            for i in commands:
                var autocomplete = i.get_autocomplete(_get_text_before_caret())
                if autocomplete != null:
                    _update_autocomplete(autocomplete)
                    return
                else:
                    autocomplete_container.off()
    )


func _update_autocomplete(text_list):
    autocomplete_container.set_autocomplete(text_list)
    var char_width = 6
    var offset_right = 14
    var y = 16
    autocomplete_container.position = clamp(
        Vector2(offset_right + ( line_edit.text.length() * char_width ), y),
        Vector2(0, y),
        Vector2(320 - autocomplete_container.size.x, y)
    )
    
    
func _get_text_before_caret():
    var text = line_edit.text.left(line_edit.caret_column)
    return text
    

static func create(p_commands: Array):
    var instance = load("uid://cplt2xqjilwh4").instantiate()
    instance.commands = p_commands
    return instance


func _show_msg(text):
    lb_msg.text = ":"+"{0}".format([text])
    for i in ["err", "error"]:
        if i in text.to_lower():
            lb_msg.modulate= Color.RED
            break
        else:
            lb_msg.modulate= Color.GREEN
    
    await get_tree().create_timer(1).timeout
    lb_msg.modulate= Color.WHITE



func _console_visible(is_visible):
    if is_visible:
        lb_msg.show()
        var animate = AnimateOffset.new(console_container, Vector2.ZERO, 0.2, false)
    else:
        lb_msg.hide()
        var animate = AnimateOffset.new(console_container, Vector2(0, -console_container.size.y), 0.2, false)
        

func _remove_word_at_caret(text, caret_index, replace_with = ""):
    var words_inside_caret= []
    var split_text = text.split(" ")
    var words_len = 0
    for i in split_text:
        if words_len > caret_index:
            break
            
        words_len = i.length() + words_len
        words_inside_caret.push_back(i)
    
    print(text)
    return text.replace(words_inside_caret.back(), replace_with)
