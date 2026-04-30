class_name WidgetGroup
extends Node

enum SelectMode{ HORIZONTAL, VERTICAL }

@export var select_mode : SelectMode = SelectMode.VERTICAL
@export var widgets : Array[Widget] = []

var _select = null

func _ready():
    _select = ListSelect.new(self, widgets, 0, select_mode)
    _select.effect_active= func(node):
        node.process_state_active()
    _select.effect_blur = func(node):
        node.process_state_blur()
