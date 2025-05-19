extends CharacterBody2D

const SPEED = 190.0
const JUMP_VELOCITY = -300.0
var is_jumping := false

@onready var animation := $anim as AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Input de movimento
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# === Animações (ordem de prioridade: pulo > correr > idle) ===
	if !is_on_floor():
		animation.play("jump")
	elif direction != 0:
		animation.play("run")
	else:
		animation.play("idle")

	move_and_slide()
