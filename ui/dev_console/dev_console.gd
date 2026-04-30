class_name DevConsole
extends Control

@export var line_edit: LineEdit
@export var lb_msg: Label
@export var btn_console: Button
@export var btn_console_container: Control
@export var console_container: Control


var commands = [ConsoleCommand.new()]
var _is_console_visible = false

func _ready():
    btn_console.pressed.connect(
        func():
            _is_console_visible = !_is_console_visible
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
        
