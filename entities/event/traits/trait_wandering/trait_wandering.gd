class_name TraitWandering

var wandering_node: WanderingNode
func _enter(event):
    wandering_node= load("uid://cd8t01ocegbc8").instance()
    event.add_child.call_deferred(wandering_node)
    
    
func _exit(event):
    wandering_node.queue_free()
    

func _update(delta, event):
    
    


    