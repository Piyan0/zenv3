extends Node

@export var parent: Node2D
@export var speed = 30

func _ready() -> void:
    parent.set_meta("transfer", func(pos):
        parent.global_position = pos    
    )
    _create_grid_movement()


func _create_grid_movement():
   var grid = GridMovement.new(parent)
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

   
   parent.set_meta("set_routes", func(routes, speed):
      grid.speed = speed
      grid.routes = routes
      await grid.movement_finished
   )

   
   parent.set_meta("alpha", func(is_transparent):
      parent.visible = is_transparent    
   )

   # TODO also set direction of player and event.
   parent.set_meta("look", func(dir_str):
      match dir_str:
         "up":
            parent.play_animation("idle_up")
         "down":
            parent.play_animation("idle_down")
         "left":
            parent.play_animation("idle_left")
         "right":
            parent.play_animation("idle_right")
   )
    
