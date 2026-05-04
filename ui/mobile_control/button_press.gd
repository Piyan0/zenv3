extends TouchScreenButton


func _ready():
    pressed.connect(func():
        modulate.a = 0.5    
    )
    released.connect(func():
        modulate.a = 1
    )
    
