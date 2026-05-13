class_name TraitEnter
extends EventTrait

func _enter(event: Event):
    event.area.area_entered.connect(func(area):
        print(1)
        if area.owner is Player:
            print(1)    
    )

    event.area.area_exited.connect(func(area):
        if area.owner is Player:
            print(2) 
    )

    