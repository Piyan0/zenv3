class_name SpawnableAnimation
extends Node2D

signal animation_finished()

var animation_data : AnimationData
var spawn_pos

var _spr
var _anim_process


func _ready():
    _spr = _add_sprite2d()
    position = spawn_pos
    _anim_process = AnimationProcess.new()
    _anim_process.target = _spr
    _anim_process.animation_data = animation_data
    _anim_process.finished.connect(func():
        queue_free()
        animation_finished.emit()
    )
    add_child(_anim_process)


static func spawn(p_animation_data, p_pos = Vector2.ZERO, p_z_index = 10):
    var instance = SpawnableAnimation.new()
    instance.z_index = p_z_index
    instance.animation_data = p_animation_data
    instance.spawn_pos = p_pos
    instance.name = "SpawnableAnimation"
    Engine.get_main_loop().current_scene.add_child(instance)
    await instance.animation_finished


func _add_sprite2d():
    var spr = Sprite2D.new()
    spr.centered = false
    add_child(spr)
    return spr
    
