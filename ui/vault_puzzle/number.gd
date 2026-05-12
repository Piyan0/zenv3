extends Control

@export var id = 0
@export var pointer: Control


func state_active():
    #rintt("active", name, 1)
    pointer.show()
    
func state_blur():
    pointer.hide()
    #printt(name, pointer.visible)
    
