class_name InputFilter
extends Node

var allow_input = func(input_ev: InputEvent): return true

func _input(ev):
    if !allow_input.call(ev):
        get_viewport().set_input_as_handled()
        

        
