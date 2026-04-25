extends Node2D
class_name WanderingNode


@export var ray: ShapeCast2D
@export var claim_tile_area: Area2D


func _ready():
    claim_tile_area.top_level= true
    ray.add_exception(claim_tile_area)
    

func add_exception(node):
    ray.add_exception(node)
    

func cast_claim_tile_to(tile_region):
    claim_tile_area.position= position + dir
    

func is_colliding(tile_region):
    ray.target_position= tile_region
    ray.force_shapecast_update()
    return ray.is_colliding()