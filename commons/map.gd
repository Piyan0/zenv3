class_name Map
extends Node2D

@export var map_id: MapID.ID
@export var bgm: AudioStream
@export var map_display_name: String

func _ready():
    #await get_tree().process_frame
    Bootstrap.event_manager.refresh_map()
