extends KinematicBody2D


const GRAVITY = 500
var velocity = Vector2()
var speed = 25
var jumpSpeed = 175

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func _input(event):
	if event.is_action_pressed("A") && is_on_floor():
		velocity.y = -jumpSpeed

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
		get_node("PlayerSprite").set_flip_h(false)
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		get_node("PlayerSprite").set_flip_h(true)
	else:
		velocity.x = 0
		
	move_and_slide(velocity, Vector2(0, -1))
	





