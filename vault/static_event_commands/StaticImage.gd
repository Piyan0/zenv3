class_name StaticImage
extends StaticEventCommand


@export var image_id = "[empty]"


func _command():
    var eva = EventPageActions.new()
    await eva.push(["show_image", image_id])