class_name StateMachine
extends Node

enum States {
	IDLE,
	WALK,
}

@onready var state_idle: Idle = $Idle
@onready var state_walk: Walk = $Walk

var active_state: AbstractState

func _ready() -> void:
	active_state = state_idle
	active_state.init()
	pass

func _process(delta: float) -> void:
	var new_state: AbstractState = active_state.process(delta)
	if new_state == null:
		return
	transition(new_state)


func transition(new_state: AbstractState) -> void:
	active_state.shutdown()
	active_state = new_state
	active_state.init()
