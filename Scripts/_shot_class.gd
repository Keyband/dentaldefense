extends Area2D

###Variaveis!
#Dano do tiro
var dano = global.dano_do_jogador
#Velocidade do tiro!
var velocidade = 500 * global.velocidade_do_tiro #100
#Direcao do tipo (pra cima ou pra baixo)
var direcao = Vector2(0, 1)
#Vida do tiro, ou seja, quantos hits ele pode dar sem sumir
var vida_do_tiro = global.vida_do_tiro
#Posicao do alvo do tiro: sera usado quando o tiro for perseguidor
var posicao_do_alvo_atual = 1000 * direcao #Vector2(1, 1)
#Alvo do tiro: a principio nao existe, ou seja, e null
var alvo = null
#Alvo atualizado do tiro: para o caso de o alvo verdadeiro deixar de existir
var alvo_atualizado = null
#Referencia fraca para o alvo, para ajudar no caso de ele sumir
var ref_fraca = null
#Esta perseguindo algum inimigo?
var perseguindo = false
#Uns coisos para a mudanca de cores no caso de o tiro ser magico
var modo = 'vermelho'
var cor_atual = Color(1, 0, 0)
var incremento_de_cor = 0.2
#Particulas de magia
onready var particulas_de_magia_preload = preload("res://Scenes/particulas_marisa.tscn")

###Funcao _ready
func _ready():
	#Setar alvo
	for node in get_tree().get_nodes_in_group('enemy'):
		if (node.get_global_position() - self.get_global_position()).length() < posicao_do_alvo_atual.length():
			perseguindo = true
			alvo = node
			alvo_atualizado = node
			ref_fraca = weakref(node)
			posicao_do_alvo_atual = node.get_global_position()
	
	#Setar cor
	var nivel_do_dano = global.nivel_dos_upgrades['dano']
	if nivel_do_dano == 0:
		set_modulate(Color(1,1,1))
	elif nivel_do_dano == 1:
		set_modulate(Color(1,0.8,0.8))
	elif nivel_do_dano == 2:
		set_modulate(Color(1,0.65,0.65))
	elif nivel_do_dano == 3:
		set_modulate(Color(0.8,0.5,0.5))
	
	#Setar processo físico
	set_physics_process(true)

###Funcao _physics_process
func _physics_process(delta):
#	print(str(alvo))
	if global.nivel_dos_upgrades['witch'] == 1:
		_shambles_color()
	
	if perseguindo and global.nivel_dos_upgrades['chase'] == 1:
		if not ref_fraca.get_ref():
			perseguindo = false
		else:
			direcao.x = lerp(direcao.x, (alvo.get_global_position() - self.get_global_position()).normalized().x, 0.1)
			direcao.y = lerp(direcao.y, (alvo.get_global_position() - self.get_global_position()).normalized().y, 0.1)
			set_rotation(direcao.angle() + PI/2)
			global_translate( direcao * velocidade * delta)
	else:
		global_translate( direcao * velocidade * delta)
		
	# Falta implementar os diferentes tipos de tiro (double shot e triple shot e dual shot),
	#ajeitar uns upgrades, e impedir upgrades/downgrades que se anularem se juntarem, e largar a preguica


###Funcao para causar dano no inimigo, ou para destruir este tiro se ele sair da tela.
func _on_shot_body_entered( body ):
	if body.is_in_group('enemy'):
		get_tree().get_current_scene().get_node('Camera2D').shake(0.2, 15, 8)
		
		body._causar_dano(self.dano)
		vida_do_tiro -= 1
		
		if global.nivel_dos_upgrades['witch'] == 1 and global.particulas == true:
			var particulas = particulas_de_magia_preload.instance()
			particulas.global_position = self.global_position
			particulas.set_emitting(true)
			get_tree().get_current_scene().add_child(particulas)
			
			#Criar uma explosao de cores
			pass
		
		if vida_do_tiro <= 0:
			self.queue_free()
	elif body.is_in_group('killer_boundary'):
		self.queue_free()
	pass # replace with function body

#func _ready():
#	set_physics_process(true)
#	pass
#
#func _physics_process(delta):
#	global_translate( direcao * velocidade * delta)
#	pass

func _shambles_color():
	#Acho que isso vai fazer o texto ficar mudando de cor. Deu mais ou menos certo eu acho...
	$Sprite.set_modulate(cor_atual)
	if modo == 'vermelho':
		cor_atual.g += incremento_de_cor
		cor_atual.b -= incremento_de_cor
		if cor_atual.g >= 1:
			modo = 'verde'
	elif modo == 'verde':
		cor_atual.b += incremento_de_cor
		cor_atual.r -= incremento_de_cor
		if cor_atual.b >= 1:
			modo = 'azul'
	elif modo == 'azul':
		cor_atual.r += incremento_de_cor
		cor_atual.g -= incremento_de_cor
		if cor_atual.r >= 1:
			modo = 'vermelho'
	$Sprite.set_modulate(cor_atual)