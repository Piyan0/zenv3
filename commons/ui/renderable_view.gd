class_name RenderableView
extends Control


func _ready():
    pass


func apply():
    _before_render()
    _render_items()
    _after_render()


# @virtual
func _before_render(item):
    pass


# @virtual
func _render_items(item):
    pass


# @virtual
func _after_render(item):
    pass
