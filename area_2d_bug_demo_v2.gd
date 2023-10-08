extends Node2D

@onready var a2d = preload("res://area2d_instance.tscn")
@onready var signal_area = $Area2D
@onready var signal_sprite = $Area2D/Sprite2D
@onready var timer = $Timer	
var rids: Array
var force
var xpos: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timeout)
	signal_area.area_entered.connect(self.signal_entered)
	signal_area.area_exited.connect(self.signal_exited)
	
func signal_entered(_area: Area2D):
	signal_sprite.modulate = Color.RED
	
func signal_exited(_area: Area2D):
	signal_sprite.modulate = Color.WHITE

func _on_timeout():
	print("Hit timeout")
	self.force = a2d.instantiate()
	self.add_child(force)
	force.position = Vector2(287.5*self.xpos, 325)
	var tween = self.create_tween()
	tween.tween_interval(0.5)
	tween.tween_callback(self.remove_force)
	if self.xpos == 1:
		self.xpos = 3
	else:
		self.xpos = 1 
	
func remove_force():
	self.rids.append(self.force.get_rid())
	for r in self.rids:
		print("Rid: ", r, " Count: ", PhysicsServer2D.area_get_shape_count(r))
	# set_gravity_space_override_mode is required to even stop the area
	# from effecting the ball after being removed.
	self.force.set_gravity_space_override_mode(0)
	self.remove_child(self.force)
	self.force.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
