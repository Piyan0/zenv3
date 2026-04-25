class_name AnimationData
extends Resource

@export var texture: Texture2D
@export var columns= 0
@export var delay_each_frame= 0.2
@export var is_loop= false
@export var frames_index: Array[int]
@export var tile_size= Vector2(16, 16)


func get_texture(idx):
    var col= (frames_index[idx] % columns) * tile_size.x
    var row= floor(frames_index[idx] / columns) * tile_size.y

    var atlas= AtlasTexture.new()
    atlas.atlas= texture
    atlas.region= Rect2(
        Vector2(col, row), tile_size
    )
    return atlas
