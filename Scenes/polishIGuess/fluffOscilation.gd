extends Sprite
var angulo=0
export(float) var deslocamento=0
func _ready():
	set_physics_process(true)
func _physics_process(delta):
	angulo+=PI/8
	self.position.y=35+15*sin(angulo*delta*15+deslocamento)
