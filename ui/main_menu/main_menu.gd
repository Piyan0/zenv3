extends Control

@export var play_button: HandPointer
@export var select_level_button: HandPointer
@export var select_language_button: HandPointer

@export var select_level_instance: Node
@export var select_language_instance: Node
@export var select_mode_instance: Node

func _ready() -> void:
    var eva_menu = EventPageActions.new()
    eva_menu.push(["play_bgm", "bgm_menu"])
    var select = ListSelect.new(self, [play_button, select_level_button, select_language_button], 0, VERTICAL)
    select.on_select_end = func(s, a):
        if s == play_button:
            select.set_pause(true)
            var is_multiplayer = await select_mode_instance.create_instance().mode_selected
            var eva = EventPageActions.new()
            select.set_pause(false)
            eva.push(["goto", "map_level_01_01"])

        elif s == select_level_button:
            select.set_pause(true)
            select_level_instance = select_level_instance as InstancePlaceholder
            var instance = select_level_instance.create_instance()
            var level = await instance.level_selected
            select.set_pause(false)
            _goto_level(level)
        elif s == select_language_button:
            select.set_pause(true)
            select_language_instance = select_language_instance as InstancePlaceholder
            var lang = await select_language_instance.create_instance().language_selected
            TranslationServer.set_locale(lang)
            select.set_pause(false)


func _goto_level(level):
    var eva = EventPageActions.new()
    match level:
        1:
            eva.push(["goto", "map_level_01_01"])
        2:
            eva.push(["goto", "map_road_01"])
        3:
            eva.push(["goto", "map_level3_1"])
        4:
            eva.push(["goto", "map_level4_1"])
        5:
            eva.push(["goto", "map_level5_1"])
