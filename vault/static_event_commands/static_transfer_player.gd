class_name StaticTransferPlayer
extends StaticEventCommand

@export var to: Vector2 = Vector2.ZERO
@export var transition = false

func _command():
    var eva = EventPageActions.new()
    if transition:
        var player = Player.instance
        player.lock_counter += 1
        var fade = await TransitionBlack.spawn()
        eva.push(["transfer", "player", to.x, to.y])
        await fade.confirm()
        player.lock_counter -= 1
    
    eva.push(["transfer", "player", to.x, to.y])