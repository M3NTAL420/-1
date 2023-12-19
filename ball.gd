extends RigidBody3D

@export var initialForce = 100.00
#@onready var forwardDirection = $Marker3D


var speed := 100000.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	apply_central_force(global_transform.basis.z * speed)
