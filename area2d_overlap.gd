extends Node2D

@onready var a2d = preload("res://area2d_instance.tscn")
var slider
@onready var station = $area2d_instance
@onready var station_sprite = $area2d_instance/Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	station.area_entered.connect(self.station_entered)
	station.area_exited.connect(self.station_exited)
	self.init_slider()

func station_entered(_area):
	self.station_sprite.modulate = Color.RED
	
func station_exited(_area):
	self.station_sprite.modulate = Color.WHITE

func init_slider():
	slider = a2d.instantiate()
	self.add_child(slider)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.slider.position.distance_to(self.station.position) <= 10:
		self.remove_child(self.slider)
		self.slider.queue_free()
		self.init_slider()
	else:
		var dir = self.slider.position.direction_to(self.station.position)
		self.slider.position += dir
