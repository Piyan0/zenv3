class_name SokobanBox
extends Node2D

@export var push_speed = 30
@export var area: Area2D
@export var tile_size = 16
@export var routes: Array[Control]

func _unhandled_input(event):
    if event.is_action_pressed("ui_accept"):
        _handle_key_accept()
        
        
func _handle_key_accept():
    var player = Player.instance
    if player.get_latest_collider() == area:
        var interact_dir = Vector2.ZERO
        var dir_from_player = player.position - position
        var dot_up = Vector2.UP.dot(dir_from_player.normalized())
        var dot_right = Vector2.RIGHT.dot(dir_from_player.normalized())
        #printt(dot_up, dot_right)
        if abs(dot_up) > abs(dot_right):
            if dot_up > 0:
                interact_dir = Vector2.UP
            else:
                interact_dir = Vector2.DOWN
        else:
            if dot_right > 0:
                interact_dir = Vector2.RIGHT
            else:
                interact_dir = Vector2.LEFT
    
        await _move_box(interact_dir * -1)
        
        
func _move_box(dir):
    var time = tile_size / float(push_speed)
    var pos = position + (dir * tile_size)
    printt(position, pos)
    # print(dir * tile_size)
    if !_is_within_path(pos):
        return
    var t = create_tween()
    t.tween_property(self, "position", pos, time)
    await t.finished
    

func _is_within_path(pos):
    var rect_self = Rect2(pos, Vector2(tile_size, tile_size))
    for i in routes:
        var rect_path = Rect2(i.global_position, Vector2(tile_size, tile_size),)
        if  rect_self.intersects(rect_path):
            return true
    return false
    
