extends Area2D

var bulletSpeed = 175
var dir: Vector2 = Vector2(0, 0)

func _ready():
	destroy()
	emit_signal("body_entered")
	connect("body_entered", self, "_on_Bullet_body_entered")

func _physics_process(delta):
	position += dir * bulletSpeed * delta

func destroy():
	var timer = Timer.new()
	add_child(timer)
	
	timer.connect("timeout", self, "queue_free")
	timer.set_wait_time(0.3)
	timer.start()

func _on_Bullet_body_entered(body):
	if body.is_in_group("tilemap"):
		queue_free()
