extends Map

@export var color: Control
@export var spr: Sprite2D


func _ready():
    super._ready()
    print(spr.z_index)
    spr.hide()
    await SpawnableAnimation.spawn(Bootstrap.asset_loader.get_asset("anim_phone"), spr.global_position)
    spr.show()
