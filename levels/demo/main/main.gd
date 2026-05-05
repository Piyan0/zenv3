extends Map

@export var color: Control
@export var spr: Sprite2D


func _ready():
    super._ready()
    SpawnableAnimation.spawn(Bootstrap.asset_loader.get_asset("anim_phone"), spr.global_position + Vector2(2,0))
