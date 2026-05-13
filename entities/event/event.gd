@icon("./icon_search.png")
class_name Event
extends Node2D

signal interact_finished()

@export var _commands_source : Script
@export var eventpages: Array[EventPage]
@export var area: Area2D
@export var spr: Sprite2D
@export var colls_shape: CollisionShape2D
@export var animation_process: AnimationProcess

var instances = []
var is_interact_running= false
var interact_direction= Vector2.ZERO
var active_event_page: EventPage
var can_interact= true

var _can_trigger_touch= true
var _touch_area= Vector2.ZERO
var _commands : EventCommands


# TODO add initial graphic / idle animation for event in editor.
func _ready():
    spr.hide()
    if _commands_source:
        _commands = _commands_source.new()
        _commands.event = name
        _commands.internal_switch = get_internal_switch_id()
        
    else:
        _commands = EventCommands.new()
    add_to_group("events")


func _exit_tree() -> void:
    interact_finished.emit()


func _physics_process(delta):
    if !active_event_page: return
    for i in active_event_page.event_traits:
        i.call_update(delta, self)


func play_animation(anim_name):
    var anim = get_animation(anim_name)
    if anim != null:
        animation_process.change_animation(anim) 


func get_animation(anim_name):
    if !active_event_page: return null
    if active_event_page.walk_animations:
        if anim_name in active_event_page.walk_animations:
            return active_event_page.walk_animations[anim_name]
    if active_event_page.idle_animations:
        if anim_name in active_event_page.idle_animations:
            return active_event_page.idle_animations[anim_name]


func get_animation_process():
    return animation_process


func get_internal_switch_id():
    var current_scene = get_tree().current_scene
    if !current_scene is Map:
        return "<internal_switch_id>"
    return current_scene.map_id + "-" + name
    
    
static func get_by_id(id):
    for i in Engine.get_main_loop().get_nodes_in_group("events"):
        if i.name == id:
            return i


static func get_keys():
    var keys = []
    for i in Engine.get_main_loop().get_nodes_in_group("events"):
        keys.push_back(str(i.name))    
    return keys


func get_size():
    return colls_shape.shape.size


func set_texture(texture):
    spr.texture= texture
    
    
func reset_texture():
    assert(active_event_page != null, str(active_event_page))
    spr.texture= active_event_page.graphic
    spr.offset= active_event_page.offset


func get_area():
    return area
    

func get_collision_space():
    return active_event_page.placement
    
    
func is_interact(player: Player, input_event: InputEvent= null):
    if active_event_page == null:
        return false
        
    match active_event_page.placement:
        EventPage.Placement.GROUND:
            return _is_interact_ground(player, input_event)
        EventPage.Placement.BELOW_GROUND, EventPage.Placement.ABOVE_GROUND:
            return _is_interact_below_or_above_ground(player, input_event)
            

func interact(player):
    if !can_interact:
        return
    var direction_from_player= player.position - position
    direction_from_player= direction_from_player.normalized()
    
    interact_direction= direction_from_player
    is_interact_running= true
    await active_event_page.exec_commands()
    interact_finished.emit.call_deferred()
    is_interact_running= false
    

func update_active_event(internal_switches, variables, global_switches):
    if active_event_page:
        for i in active_event_page.event_traits:
            i.exit(self)
    var reversed_event_pages= eventpages.duplicate()
    reversed_event_pages.reverse()
    for i in reversed_event_pages:
        if i == null: continue
        # TODO return if event is the same, since everytime variable / switch is changed, it will be called.
        if i.is_event_active(internal_switches[get_internal_switch_id()], variables, global_switches):
            if i == active_event_page:
                # print("same")
                return
            active_event_page= i
            _active_event_changed(i)

            for j in active_event_page.event_traits:
                j.enter(self)
            return
    
    
func _update_trigger_touch(player):
    if player.position != _touch_area:
        _can_trigger_touch= true
        

func _active_event_changed(event_page: EventPage):
    event_page.event_commands = _commands.get_event_commands(event_page.event_commands_id)
    area.collision_layer = 0
    # TODO play initial idle animation.
    spr.show()
    spr.texture= event_page.graphic
    spr.offset= event_page.graphic_offset
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
    if event_page.through:
            area.collision_layer = 0
        


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
            if !input_event: return
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
            if !input_event: return
            if !player.is_moving():
                var interact_threshold= 1.0
                var distance_from_player= abs( position.distance_to(player.position) )
                if input_event.is_action_pressed("ui_accept") && distance_from_player <= interact_threshold:
                    return true
        
        EventPage.Trigger.AUTORUN:
            return true
    
    return false
