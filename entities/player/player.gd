extends Node2D


@export var anim: AnimationPlayer
@export var grid_mov: GridMovement

func _ready():
    grid_mov.on_direction_changed= func(d, prev):
        match d:
            Vector2.ZERO:
                anim.stop()
            Vector2.UP:
                anim.play("w_up")
            Vector2.DOWN:
                anim.play("w_down")
            Vector2.LEFT:
                anim.play("w_left")
            Vector2.RIGHT:
                anim.play("w_right")
