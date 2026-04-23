class_name GridMovement
extends Node2D

@export var tile_size = 16
@export var target: CharacterBody2D
@export var speed = 60 # Pixel per detik

var _pixel_moved = 0
var _direction = Vector2.ZERO
var _is_process_walk = false
var _step_size = 0.0
var _step = 0.0

func _ready():
    # Jika speed 60, maka _step_size = 0.0166 detik per pixel
    _step_size = 1.0 / speed

func _physics_process(delta: float) -> void:
    _update_direction()
    _process_movement(delta)

func _update_direction():
    if _is_process_walk: return
    
    var input_dir = Vector2.ZERO
    if Input.is_action_pressed("ui_up"): input_dir = Vector2.UP
    elif Input.is_action_pressed("ui_down"): input_dir = Vector2.DOWN
    elif Input.is_action_pressed("ui_left"): input_dir = Vector2.LEFT
    elif Input.is_action_pressed("ui_right"): input_dir = Vector2.RIGHT
    
    if input_dir != Vector2.ZERO:
        _direction = input_dir

func _process_movement(delta):
    if _direction == Vector2.ZERO: return
    
    _is_process_walk = true
    _step += delta
    
    # "while" akan memproses semua pixel yang seharusnya jalan selama waktu delta
    # Ini kunci biar gak stutter pas FPS drop di bawah 24
    while _step >= _step_size and _is_process_walk:
        target.move_and_collide(_direction)
        _step -= _step_size
        _pixel_moved += 1
        
        # Jika sudah menempuh 1 kotak (16px)
        if _pixel_moved >= tile_size:
            _pixel_moved = 0
            _step = 0 # Reset sisa waktu agar tidak kebablasan ke kotak berikutnya
            _direction = Vector2.ZERO
            _is_process_walk = false
