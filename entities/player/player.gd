class_name Player
extends Node2D

@export var anim: AnimationPlayer
@export var grid_mov: InputGridMovement
@export var ray: RayCast2D

static var instance: Player

var lock_input= false:
    set(value):
        lock_input= value
        grid_mov.lock_input= value
        

func _ready():
    instance= self
    grid_mov.on_sprint_changed= func(sprint):
        if sprint:
            anim.speed_scale= 1.8
        else:
            anim.speed_scale= 1.5
    
    grid_mov.can_move= func(dir):
        var angles= [-20, 0, 20]
        for i in angles:
            ray.rotation_degrees= i
            ray.target_position= dir * 16
            ray.force_raycast_update()
            if ray.is_colliding():
                return false
            
        return true
        
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

func get_latest_collider():
    ray.force_raycast_update()
    return ray.get_collider()
    

func is_moving():
    return grid_mov.is_moving()
