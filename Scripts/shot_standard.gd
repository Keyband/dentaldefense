extends "res://Scripts/_shot_class.gd"
#extends Node2D

# Variaveis da classe "shot" e seus valores default:
#	dano = 1
#	velocidade = 100
#	direcao = Vector2(0, 1) (esse aqui deve ser setado dentro do script de jogador)
#var direcao = 0

func _ready():
	### Setar propriedades ###
#	dano = 1
#	velocidade = 650
#	get_node('shot1').direcao = self.direcao.rotated( - PI/8)
#	get_node('shot2').direcao = self.direcao
#	get_node('shot3').direcao = self.direcao.rotated( + PI/8)
	pass
	### Setar processo físico ###
#	set_physics_process(true)


#func _process(delta):
	### Transladar ###
#	direcao = (alvo.get_global_position() - self.get_global_position()).normalized()
##	set_rotation(direcao.angle() + PI/2)
##	global_translate( direcao * velocidade * delta)
#
#
#func _on_Timer_timeout():
#	queue_free()
#	pass # replace with function body
