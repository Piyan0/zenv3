class_name Event
extends Node2D

signal interact_finished()


@export var eventpages: Array[EventPage]
@export var area: Area2D
@export var spr: Sprite2D

var is_interact_running= false
var interact_direction= Vector2.ZERO
var active_event_page: EventPage

var _can_trigger_touch= true
var _touch_area= Vector2.ZERO


func _ready():
    add_to_group("events")


func _physics_process(delta):
    if !active_event_page: return
    for i in active_event_page.event_traits:
        i.call_update(delta, self)
        
        
func set_texture(texture):
    spr.texture= texture
        
        
func is_interact(player: Player, input_event: InputEvent= null):
    match active_event_page.placement:
        EventPage.Placement.GROUND:
            return _is_interact_ground(player, input_event)
        EventPage.Placement.BELOW_GROUND, EventPage.Placement.ABOVE_GROUND:
            return _is_interact_below_or_above_ground(player, input_event)
            

func interact(player):
    var direction_from_player= player.position - position
    direction_from_player= direction_from_player.normalized()
    
    interact_direction= direction_from_player
    is_interact_running= true
    var commands= active_event_page.get_commands()
    await commands.execute_commands()
    interact_finished.emit()
    is_interact_running= false
    


func update_active_event(internal_switches, variables, global_switches):
    if active_event_page:
        for i in active_event_page.event_traits:
            i.exit(self)

    var reversed_event_pages= eventpages.duplicate()
    reversed_event_pages.reverse()
    for i in reversed_event_pages:
        if i.is_event_active(internal_switches, variables, global_switches):
            active_event_page= i
            _active_event_changed(i)

            for j in active_event_page.event_traits:
                j.enter(self)
            return

    
    
    
func _update_trigger_touch(player):
    if player.position != _touch_area:
        _can_trigger_touch= true
        

func _active_event_changed(event_page: EventPage):
    area.collision_layer= 0
    spr.texture= event_page.graphic
    match event_page.placement:
        EventPage.Placement.BELOW_GROUND:
            area.set_collision_layer_value(1, true)
            z_index= 0
        EventPage.Placement.GROUND:
            area.set_collision_layer_value(2, true)
            z_index= 10
        EventPage.Placement.ABOVE_GROUND:
            area.set_collision_layer_value(3, true)
            z_index= 20


func _is_interact_ground(player, input_event):
    match active_event_page.trigger:
        EventPage.Trigger.PLAYER_TOUCH:
            if !player.is_moving():
                if !_can_trigger_touch:
                    _update_trigger_touch(player)
                    return false
                
                if player.get_latest_collider() == area:
                    _can_trigger_touch= false
                    _touch_area= player.position
                    return true
            
        EventPage.Trigger.INTERACT_BUTTON:
            if !player.is_moving():
                if input_event.is_action_pressed("ui_accept"):
                    if player.get_latest_collider() == area:
                        return true
                    
        EventPage.Trigger.AUTORUN:
            return true
    
    return false


func _is_interact_below_or_above_ground(player, input_event):
    match active_event_page.trigger:
        EventPage.Trigger.PLAYER_TOUCH:
            if !player.is_moving():
                if !_can_trigger_touch:
                    _update_trigger_touch(player)
                    return false
                
                var touch_threshold= 1.0
                var distance_from_player= abs( position.distance_to(player.position) )
                if distance_from_player <=  touch_threshold:
                    _can_trigger_touch= false
                    _touch_area= player.position
                    return true
            
        EventPage.Trigger.INTERACT_BUTTON:
            if !player.is_moving():
                var interact_threshold= 1.0
                var distance_from_player= abs( position.distance_to(player.position) )
                if input_event.is_action_pressed("ui_accept") && distance_from_player <= interact_threshold:
                    return true
        
        EventPage.Trigger.AUTORUN:
            return true
    
    return false
