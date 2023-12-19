extends CharacterBody3D
var Health = 10
var is_invincible = false
const SPEED = 5.0
const JUMP_VELOCITY = 10
@onready var mesh = $MeshInstance3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var spring_arm:SpringArm3D = $SpringArm3D
var angular_acceleration = 5

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(direction.x, direction.z), delta * angular_acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_area_3d_body_entered(body):
	if body.is_in_group('enemy') && !is_invincible:
		Health -= 1
		$Area3D/ProgressBar.value = Health * 10
		velocity = body.linear_velocity * 15
		velocity.y = 0
		$Area3D/ProgressBar/Timer.start()
		move_and_slide()
		is_invincible = true
	pass # Replace with function body.


func _on_timer_timeout():
	is_invincible = false
	pass # Replace with function body.
