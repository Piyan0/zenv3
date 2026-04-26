extends Node2D
class_name WanderingNode

@export var ray: ShapeCast2D
@export var claim_tile_area: Area2D

func _ready():
    claim_tile_area.top_level= true
    claim_tile_area.position= global_position
    ray.add_exception(claim_tile_area)
    

func add_exception(node):
    ray.add_exception(node)
    

func cast_claim_tile_to(tile_region):
    claim_tile_area.position= global_position + tile_region
    

func is_colliding(tile_region):
    ray.target_position= tile_region
    ray.force_shapecast_update()
    return ray.is_colliding()
    

func set_collision_space(bit: int):
    ray.collision_mask= 0
    claim_tile_area.collision_mask= 0
    claim_tile_area.collision_layer= 0
    
    ray.set_collision_mask_value(bit, true)
    claim_tile_area.set_collision_layer_value(bit, true)
    claim_tile_area.set_collision_mask_value(bit, true)
