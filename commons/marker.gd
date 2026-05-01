class_name Marker
extends Marker2D

static var markers_in_area = {}

func _ready() -> void:
    markers_in_area[str(name)] = self


func _exit_tree() -> void:
    markers_in_area.erase(name)


static func get_pos(key):
    if key in markers_in_area:
        return markers_in_area[key].global_position
    else:
        return null


static func get_keys():
    return markers_in_area.keys()
