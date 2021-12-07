extends KinematicBody2D

var bulletSpeed = 175
var velocity = Vector2()
var dir: Vector2 = Vector2(0, 0)

func _ready():
	destroy()

func _physics_process(delta):
	velocity.x = bulletSpeed
	var coll = move_and_collide(velocity * dir * delta)
	if coll:
		queue_free()

func destroy():
	var timer = Timer.new()
	add_child(timer)
	
	timer.connect("timeout", self, "queue_free")
	timer.set_wait_time(0.3)
	timer.start()
