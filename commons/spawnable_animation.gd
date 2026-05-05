class_name SpawnableAnimation
extends Node2D

signal animation_finished()

var animation_data : AnimationData
var spawn_pos

var _spr
var _anim_process


func _ready():
    _spr = _add_sprite2d()
    _spr.global_position = spawn_pos
    _anim_process = AnimationProcess.new()
    _anim_process.target = _spr
    _anim_process.animation_data = animation_data
    _anim_process.finished.connect(func():
        queue_free()
        animation_finished.emit()
    )
    add_child(_anim_process)


static func spawn(p_animation_data, p_pos = Vector2.ZERO):
    var instance = SpawnableAnimation.new()
    instance.animation_data = p_animation_data
    instance.spawn_pos = p_pos
    instance.name = "SpawnableAnimation"
    Bootstrap.world_canvas.add_child(instance)
    await instance.animation_finished


func _add_sprite2d():
    var spr = Sprite2D.new()
    spr.centered = false
    add_child(spr)
    return spr
    
