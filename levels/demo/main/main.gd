extends Node2D


@export var color: ColorRect
@export var spr: Sprite2D
@export var ray: ShapeCast2D
@export var colls: Area2D

var x: GridMovement

func _ready():
    colls.top_level= true
    ray.add_exception(colls)
    x= GridMovement.new(spr)
    x.speed= 30
    x.delay= 0.0
    x.on_direction_changed= func(dir, prev_dir):
        print("dir has changed to: ", dir)
    
    x.on_claim_tile= func(dir):
        colls.position= dir
    
    x.can_move= func(pos):
        var p= spr.to_local(pos)
        ray.target_position= p
        ray.force_shapecast_update()
        return !ray.is_colliding()
    
    x.routes= [Vector2.RIGHT, Vector2.RIGHT, Vector2.DOWN]
    #colls.global_position= x.get_next_tile_pos(spr.position, 0)

func _process(delta: float) -> void:
    if x:
        x.update(delta)
