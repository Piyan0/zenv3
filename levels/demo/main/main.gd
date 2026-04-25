extends Node2D


@export var color: ColorRect
@export var spr: Sprite2D
@export var ray: RayCast2D

var x: GridMovement

func _ready():
    x= GridMovement.new(spr)
    x.on_direction_changed= func(dir, prev_dir):
        print("dir has changed to: ", dir)
    
    x.can_move= func(dir):
        ray.target_position= dir * Vector2(16, 16)
        ray.force_raycast_update()
        return !ray.is_colliding()
    
    x.routes= [Vector2.RIGHT, Vector2.RIGHT, Vector2.DOWN]

func _process(delta: float) -> void:
    if x:
        x.update(delta)

