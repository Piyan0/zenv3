extends Map


func _ready():
    super._ready()
    await get_tree().create_timer(1).timeout
    await get_tree().process_frame   
