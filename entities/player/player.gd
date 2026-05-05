class_name Player
extends Node2D

enum Direction{ UP, DOWN, LEFT, RIGHT }
@export_group("Movement Animation")
@export var walk_up: AnimationData
@export var walk_down: AnimationData
@export var walk_left: AnimationData
@export var walk_right: AnimationData
@export var idle_up: AnimationData
@export var idle_down: AnimationData
@export var idle_left: AnimationData
@export var idle_right: AnimationData
@export_group("")

@export var initial_direction: Direction
@export var animation_process: AnimationProcess
@export var grid_mov: InputGridMovement
@export var ray: RayCast2D
static var instance: Player


var lock_counter = 0:
    set(value):
        # print(value)
        lock_counter = value
        if lock_counter > 0:
            grid_mov.lock_input = true
        else:
            grid_mov.lock_input = false


func _ready():
    instance= self
    match initial_direction:
        Direction.UP:
            animation_process.change_animation(idle_up)
        Direction.DOWN:
            animation_process.change_animation(idle_down)
        Direction.LEFT:
            animation_process.change_animation(idle_left)
        Direction.RIGHT:
            animation_process.change_animation(idle_right)
        
    #grid_mov.on_sprint_changed= func(sprint):
        #if sprint:
            #anim.speed_scale= 1.8
        #else:
            #anim.speed_scale= 1.5
    #
    grid_mov.can_move= func(dir):
        var angles= [-20, 0, 20]
        for i in angles:
            ray.rotation_degrees= i
            ray.target_position= dir * 16
            ray.force_raycast_update()
            if ray.is_colliding():
                return false
            
        return true
        
    grid_mov.on_direction_changed= func(dir, prev):
        match dir:
            Vector2.ZERO:
                match prev:
                    Vector2.UP:
                        animation_process.change_animation(idle_up)
                    Vector2.DOWN:
                        animation_process.change_animation(idle_down)
                    Vector2.LEFT:
                        animation_process.change_animation(idle_left)
                    Vector2.RIGHT:
                        animation_process.change_animation(idle_right)
            Vector2.UP:
                animation_process.change_animation(walk_up)
            Vector2.DOWN:
                animation_process.change_animation(walk_down)
            Vector2.LEFT:
                animation_process.change_animation(walk_left)
            Vector2.RIGHT:
                animation_process.change_animation(walk_right)
  

func get_latest_collider():
    ray.force_raycast_update()
    return ray.get_collider()
    

func is_moving():
    return grid_mov.is_moving()
