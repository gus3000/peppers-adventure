class_name Walk
extends AbstractState

func process(_delta: float) -> AbstractState:
	var horizontal_movement: float = Input.get_axis("left", "right")
	if horizontal_movement == 0:
		return state_machine.state_idle
	return null

func shutdown(): Log.pr("shutdown")

func init():
	Log.pr("init")
	animator.play("Walk")