extends StaticEventCommand

@export var sokoban_source_name = ""

func _command():
    Player.instance.lock_counter =+ 1
    var eva = EventPageActions.new()

    await eva.push(["choices", ["ui_reset_box", "ui_cancel"], func(id):
        if id == 0:
            SokobanSource.reset_pos(sokoban_source_name)

        Player.instance.lock_counter =+ 1
    ])