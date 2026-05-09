class_name StaticAddItem
extends StaticEventCommand

@export var item_id = 0
func _command():
    var eva = EventPageActions.new()
    eva.push(["add_item", item_id])