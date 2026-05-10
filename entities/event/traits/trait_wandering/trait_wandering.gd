class_name TraitWandering
extends EventTrait

enum Direction{ UP, DOWN, LEFT, RIGHT }

#TODO use animation from the event source.
@export_group("Walk Animation")
@export var walk_up: AnimationData
@export var walk_down: AnimationData
@export var walk_left: AnimationData
@export var walk_right: AnimationData
@export_group("")

@export var speed= 30
@export var delay= 0.0
@export var tile_size= Vector2(16,16)
@export var routes: Array[Direction]
@export var trait_idle: TraitIdleAnimation
@export var start_on_ready = true
@export var repeat = false

var _walk_anim_process: AnimationProcess
var _wandering_node: WanderingNode
var _grid_mov: GridMovement
var _direction_map= {
    Direction.UP: Vector2.UP,
    Direction.DOWN: Vector2.DOWN,
    Direction.LEFT: Vector2.LEFT,
    Direction.RIGHT: Vector2.RIGHT,
}

var _animation_map= {}
func _enter(event):
    _animation_map= {
        Vector2.UP: walk_up,
        Vector2.DOWN: walk_down,
        Vector2.LEFT: walk_left,
        Vector2.RIGHT: walk_right,
    }
    _walk_anim_process= AnimationProcess.new()
    _walk_anim_process.target= event.spr
    event.add_child.call_deferred(_walk_anim_process)
    
    _wandering_node= load("uid://cd8t01ocegbc8").instantiate()
    # _wandering_node.claim_tile_area.area_entered.connect(func(area):
    #     if area.get_parent() is Player:
    #         for i in claim_tile_entered_events:
    #             await i.run_command()
    # )
    _wandering_node.position= event.area.position
    _wandering_node.add_exception(event.get_area())
    _wandering_node.set_collision_space(event.get_collision_space())
    event.add_child.call_deferred(_wandering_node)
    
    _grid_mov= GridMovement.new(event)
    _grid_mov.repeat = repeat
    _grid_mov.speed= speed
    _grid_mov.delay= delay
    _grid_mov.tile_size= tile_size
    
    _grid_mov.on_direction_changed= func(dir, prev_dir):
        if dir == Vector2.ZERO:
            if trait_idle == null:
                return
            # print(prev_dir)
            match prev_dir:
                Vector2.UP:
                    _walk_anim_process.change_animation(trait_idle.idle_up)
                Vector2.DOWN:
                    _walk_anim_process.change_animation(trait_idle.idle_down)
                Vector2.LEFT:
                    _walk_anim_process.change_animation(trait_idle.idle_left)
                Vector2.RIGHT:
                    _walk_anim_process.change_animation(trait_idle.idle_right)
            return
            
        var walk_animation= _animation_map[dir]
        if !walk_animation:
            return
        _walk_anim_process.change_animation(walk_animation)
    
    _grid_mov.on_claim_tile= func(tile_reg):
        if !is_instance_valid(_wandering_node): return
        _wandering_node.cast_claim_tile_to(tile_reg)
    
    _grid_mov.can_move= func(tile_reg):
        if event.active_event_page.through:
            if is_instance_valid(_wandering_node):
                _wandering_node.queue_free()
            return true
        # prevent walking while interact is running.
        if event.is_interact_running: return false
        var is_colliding= _wandering_node.is_colliding(tile_reg)
        # print(is_colliding)
        return !is_colliding
    
    # initial idle animation.
    if trait_idle:
        _walk_anim_process.change_animation(trait_idle.idle_down)
        
    if routes:
        var parsed_routes= func():
            var r= []
            for i in routes:
                r.push_back(_direction_map[i])
            return r
        
        _grid_mov.routes= parsed_routes.call()
    
    
func _exit(event):
    _wandering_node.queue_free()
    _walk_anim_process.queue_free()
    

func _update(delta, event):
    _grid_mov.update(delta)
    if event.is_interact_running:
        _walk_anim_process.pause= true
    else:
        _walk_anim_process.pause= false
    # prevent interact to be happen when 'event' is currently walking.
    if _grid_mov.get_direction() == Vector2.ZERO:
        event.can_interact= true
    else:
        event.can_interact= false
        
