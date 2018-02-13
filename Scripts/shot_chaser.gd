extends "res://Scripts/_shot_class.gd"

# Variaveis da classe "shot" e seus valores default:
#	dano = 1
#	velocidade = 100
#	direcao = Vector2(0, 1) (esse aqui deve ser setado dentro do script de jogador)

var posicao_do_alvo_atual = 1000 * Vector2(1, 1)
var alvo = null

func _ready():
	### Setar propriedades ###
	dano = 1
	velocidade = 250
	
	### Setar alvo ###
	for node in get_parent().get_children():
		if node.is_in_group('enemy'):
			if (node.get_global_position() - self.get_global_position()).length() < posicao_do_alvo_atual.length():
				alvo = node
#				posicao_do_alvo_atual = node.get_global_position()

	### Setar processo físico ###
	set_physics_process(true)


func _process(delta):
	### Transladar ###
	direcao = (alvo.get_global_position() - self.get_global_position()).normalized()
	set_rotation(direcao.angle() + PI/2)
	global_translate( direcao * velocidade * delta)
