class_name Map
extends Node2D

@export var map_id: String = "[map_id]"
@export var bgm: AudioStream
@export var map_display_name: String

func _ready():
    var events = get_tree().get_nodes_in_group("events")
    for i in events:
        Bootstrap.progression.add_internal_switch(i.get_internal_switch_id())
    
    var progression_data= Bootstrap.progression.get_data()
    Bootstrap.event_manager.refresh_map(
        progression_data[Progression.KEY_INTERNAL_SWITCHES],
        progression_data[Progression.KEY_VARIABLES],
        progression_data[Progression.KEY_GLOBAL_SWITCHES],
    )
