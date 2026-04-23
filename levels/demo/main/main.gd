extends Node2D


@export var spr: CharacterBody2D

func _physics_process(delta: float) -> void:
    if Engine.get_frames_drawn() < 100: return
    #print(Engine.get_frames_drawn())
    spr.move_and_collide(Vector2.RIGHT * 1)
