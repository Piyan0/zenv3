class_name DevCommand
extends ConsoleCommand

func _init():
    prefix = "dev"
    
    sub_commands[".inv"] = {
        dk_ACTION : func(args):
            var inven = load("uid://c1148pqf8xuv8").instantiate()
            Bootstrap.canvas.add_child(inven)
            ,
    }
