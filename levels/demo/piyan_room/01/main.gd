extends Map


func _ready():
    super._ready()
    await get_tree().process_frame
    await get_tree().process_frame
    await get_tree().process_frame
    var p = Player.instance
    p.get_meta("walk_down").call()
    print(p)
