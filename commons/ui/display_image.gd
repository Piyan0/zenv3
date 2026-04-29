class_name DisplayImage
extends Node

signal enter_pressed()
signal finished()

var _image: Texture2D
var _texture_rect: TextureRect
var _fade_duration= 0.2

func _ready():
    _texture_rect= _add_texture_rect()
    await _show_image()
    finished.emit()
    queue_free()


func _exit_tree():
    _texture_rect.queue_free()


func _input(event: InputEvent):
    if event.is_action_pressed("ui_accept"):
        enter_pressed.emit()
        
  
static func spawn(image_id):
    var instance= DisplayImage.new()
    instance.name= "DisplayImage"
    var image= Bootstrap.asset_database.get_asset(AssetDatabase.IMAGE, image_id)
    instance._image= image
    Bootstrap.add_child(instance)
    await instance.finished
    

func _add_texture_rect():
    var tr= TextureRect.new()
    tr.texture= _image
    tr.set_anchors_and_offsets_preset(Control.LayoutPreset.PRESET_FULL_RECT)
    tr.modulate= Color.TRANSPARENT
    Bootstrap.canvas.add_child(tr)
    return tr
    
    
func _show_image():
    var t= create_tween()
    t.tween_property(_texture_rect, "modulate", Color.WHITE, _fade_duration)
    t.tween_callback(func():
        t.pause()
        await enter_pressed
        t.play()
        )
    t.tween_property(_texture_rect, "modulate", Color.TRANSPARENT, _fade_duration)
    await t.finished
    
    
