extends Control
signal level_selected(id)

@export var btn_level1: HandPointer
@export var btn_level2: HandPointer
@export var btn_level3: HandPointer
@export var btn_level4: HandPointer
@export var btn_level5: HandPointer


func _ready() -> void:
    var select = ListSelect.new(self, [btn_level1, btn_level2, btn_level3, btn_level4, btn_level5], 0, VERTICAL)
    select.on_select_end = func(s, a):
        var level = 0
        match s:
            btn_level1:
                level = 1
            btn_level2:
                level = 2
            btn_level3:
                level = 3
            btn_level4:
                level = 4
            btn_level5:
                level = 5
        level_selected.emit(level)
        queue_free()