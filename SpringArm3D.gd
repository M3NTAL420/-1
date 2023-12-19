extends SpringArm3D
@export var mouse_sensitivity =0.005

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		# Called every frame. 'delta' is the elapsed time since the previous frame.
		rotation.x -= event.relative.y * mouse_sensitivity
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(30))
		
		rotation.y -= event.relative.x * mouse_sensitivity
		rotation.y = wrapf(rotation.y, -PI, PI)

func _process(_delta):
	pass
