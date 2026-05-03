class_name Map
extends Node2D

@export var map_id: String = "[map_id]"
@export var bgm: AudioStream
@export var map_display_name: String

func _ready():
    #await get_tree().process_frame
    var progression_data= Bootstrap.progression.get_data()
    #print(progression_data)
    #print(progression_data[Progression.KEY_GLOBAL_SWITCHES])
    Bootstrap.event_manager.refresh_map(
        progression_data[Progression.KEY_INTERNAL_SWITCHES],
        progression_data[Progression.KEY_VARIABLES],
        progression_data[Progression.KEY_GLOBAL_SWITCHES],
    )
