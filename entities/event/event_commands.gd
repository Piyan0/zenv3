class_name EventCommands


func execute_commands():
    await _commands()
    
    
func _commands():
    print("this is default event commands.")
    await Engine.get_main_loop().create_timer(2).timeout
    pass
