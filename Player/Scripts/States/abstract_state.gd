@abstract
class_name AbstractState
extends Node

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var state_machine: StateMachine = $".."
@onready var animator: AnimationPlayer = player.get_node("Model/AnimationPlayer")

@abstract
func process(delta: float) -> AbstractState

@abstract
func shutdown()

@abstract
func init()