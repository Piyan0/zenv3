class_name SokobanBox
extends Node2D

signal box_pushed()

@export var push_speed = 60
@export var area: Area2D
@export var tile_size = 16
@export var routes: Array[Node2D]
@export var ray: RayCast2D
@export var box_id = "box"
@export var texture: Texture2D
@export var offset = Vector2.ZERO
@export var spr_main: Sprite2D


var _initial_pos = Vector2.ZERO


func _ready() -> void:
    spr_main.texture = texture
    spr_main.offset = offset
    ray.add_exception(area)
    if Player.instance:
        ray.add_exception(Player.instance.area)
    set_deferred("_initial_pos", global_position)


func _unhandled_input(event):
    if event.is_action_pressed("ui_accept"):
        _handle_key_accept()
        
        
func _handle_key_accept():
    var player = Player.instance
    if player.get_latest_collider() == area:
        var interact_dir = Vector2.ZERO
        var dir_from_player = player.position - global_position
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
        box_pushed.emit()
        

func reset_pos():
    global_position = _initial_pos


func _move_box(dir):
    var time = tile_size / float(push_speed)
    var pos = global_position + (dir * tile_size)
    if !_is_within_path(pos):
        return
    if !_can_move_to_dir(dir):
        return
    var t = create_tween()
    t.tween_property(self, "global_position", pos, time)
    await t.finished
    

func _is_within_path(pos):
    # origin is in bottom left, need to add lift the rect by y - tile_size.
    var rect_self = Rect2(pos + Vector2(0, - tile_size), Vector2(tile_size, tile_size))
    # print(rect_self)
    for i in routes:
        var rect_path = Rect2(i.global_position, Vector2(tile_size, tile_size),)
        # print(">> ", rect_path)
        if  rect_self.intersects(rect_path):
            return true
    return false
    


func _can_move_to_dir(dir):
    ray.target_position = dir * tile_size
    ray.force_raycast_update()
    return !ray.is_colliding()
