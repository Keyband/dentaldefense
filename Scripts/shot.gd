extends Area2D

var dano = 1
var velocidade = 200
var direcao = Vector2(0, 1)

func _ready():
	set_physics_process(true)
	pass

func _physics_process(delta):
	global_translate( direcao * velocidade * delta)
	pass


func _on_shot_body_entered( body ):
	if body.is_in_group('enemy'):
		body._causar_dano(self.dano)
		self.queue_free()
	pass # replace with function body
