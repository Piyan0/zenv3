extends Node

@export var speed = 60
@export var tile_size = 16
@export var parent: Node2D

var grid: GridMovement
var routes_queue = []
func _ready():
    grid = GridMovement.new(parent)
    grid.speed = speed
    # grid.repeat = true

    grid.on_direction_changed = func(dir, prev_dir):
        match dir:
            Vector2.ZERO:
                match prev_dir:
                    Vector2.UP:
                        parent.play_animation("idle_up")
                    Vector2.DOWN:
                        parent.play_animation("idle_down")
                    Vector2.LEFT:
                        parent.play_animation("idle_left")
                    Vector2.RIGHT:
                        parent.play_animation("idle_right")

            Vector2.UP:
                parent.play_animation("walk_up")
            Vector2.DOWN:
                parent.play_animation("walk_down")
            Vector2.LEFT:
                parent.play_animation("walk_left")
            Vector2.RIGHT:
                parent.play_animation("walk_right")


    parent.set_meta("set_movement_repeat", func(repeat):
        grid.repeat = repeat    
    )

    parent.set_meta("move_up", func():
        routes_queue.push_back(Vector2.UP)    
    )

    parent.set_meta("move_down", func():
        routes_queue.push_back(Vector2.DOWN)    
    )

    parent.set_meta("move_left", func():
        routes_queue.push_back(Vector2.LEFT)    
    )

    parent.set_meta("move_right", func():
        routes_queue.push_back(Vector2.RIGHT)    
    )

    parent.set_meta("set_routes", func(routes):
        grid.routes = routes    
        await grid.movement_finished
    )

    parent.set_meta("start_move", func():
        grid.routes = routes_queue.duplicate()    
        await grid.movement_finished
        routes_queue = []
    )

    parent.set_meta("transfer", func(pos):
        parent.global_position = pos    
    )

    parent.set_meta("look", func(direction):
        match direction:
            "up":
                parent.play_animation("idle_up")
            "down":
                parent.play_animation("idle_down")
            "left":
                parent.play_animation("idle_left")
            "right":
                parent.play_animation("idle_right")
    )
    
    
