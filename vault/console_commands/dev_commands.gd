class_name DevCommand
extends ConsoleCommand

func _init():
    prefix = "dev"
    
    sub_commands["inv"] = {
        dk_ACTION : func(args):
            var player = Player.instance
            if player != null:
                player.lock_counter += 1
            var inven = load("uid://c1148pqf8xuv8").instantiate()
            inven.items_id = Bootstrap.save_system.fields["items_id"]
            inven.inventory_closed.connect(func(items):
                if player:
                    player.lock_counter -= 1
                Bootstrap.save_system.fields["items_id"] = items
            )
            Bootstrap.canvas.add_child(inven)
            ,
    }

    sub_commands["dialogue"] = {
        dk_ACTION : func(args):
            var dialogue = load("uid://dws6emg1mc14n").instantiate()
            Bootstrap.canvas.add_child(dialogue)
            ,
    }
