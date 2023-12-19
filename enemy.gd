extends RigidBody3D

const SPEED = 100.0
var player_detected = false
var player = null
var health = 1

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	if player_detected:
		var move_direction = (player.global_position - global_position).normalized()
		apply_central_force(move_direction * SPEED)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hit_box_area_entered(body):
	if body.is_in_group("Bullet"):
		if health <= 0:
	pass # Replace with function body.
