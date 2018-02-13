extends "res://Scripts/_shot_class.gd"

# Variaveis da classe "shot" e seus valores default:
#	dano = 1
#	velocidade = 100
#	direcao = Vector2(0, 1) (esse aqui deve ser setado dentro do script de jogador)

func _ready():
	### Setar propriedades ###
	dano = 1
	velocidade = 600

	### Setar processo físico ###
	set_physics_process(true)


func _process(delta):
	### Transladar ###
	global_translate( direcao * velocidade * delta)
