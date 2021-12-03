extends KinematicBody2D

var Bullet = preload("res://Bullet.tscn")

const GRAVITY = 500
var velocity = Vector2()
var speed = 40
var jumpSpeed = 175

var Direction = "Right"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("A") && is_on_floor():
		velocity.y = -jumpSpeed
	if event.is_action_pressed("B"):
		shoot()

func _physics_process(delta):
	if !is_on_floor() && !is_on_ceiling():
		velocity.y += delta * GRAVITY
	elif is_on_floor() && velocity.y >= 0:
		velocity.y = 0.01
	if is_on_ceiling():
		velocity.y = 0
		velocity.y += delta * GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		Direction = "Right"
		flip()
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		Direction = "Left"
		flip()
	else:
		velocity.x = 0
		
	move_and_slide(velocity, Vector2(0, -1))
	

func shoot():
	var b = Bullet.instance()
	owner.add_child(b)
	if Direction == "Left":
		b.dir = Vector2(-1, 0)
	if Direction == "Right":
		b.dir = Vector2(1, 0)
	b.transform = $Position2D.global_transform
	

func flip():
	if Direction == "Left":
		get_node("PlayerSprite").set_flip_h(true)
		get_node("Position2D").position.x = -4.5
		Direction = "Left"
	if Direction == "Right":
		get_node("PlayerSprite").set_flip_h(false)
		get_node("Position2D").position.x = 4.5
		Direction = "Right"
