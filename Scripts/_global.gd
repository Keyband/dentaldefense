extends Node

###Variaveis globais

#Dano do jogador
var dano_do_jogador = 1

#Velocidade do tiro
#var velocidade_do_tiro = 100
#Tempo entre os tiros
var velocidade_do_tiro = 0.8


#Numero de bombas
var numero_de_bombas_do_jogador = 2#10000000#3
var numero_de_bombas_que_o_jogador_tem = 0#10000000#0
#Vida do dente
var vida_do_dente = 2

#Vida do tiro (i.e. penetracao)
# 1 = zero de penetracao
var vida_do_tiro = 1

#Municao do jogador
var municao_maxima_do_jogador = 150

#Os tipos de tiro sao:
#	normal
#	chaser
#	spread
var tipo_do_tiro = 'normal'

#Velocidade maxima do jogador
var velocidade_maxima_do_jogador = 300

#Numero de dentes. Default = 8?. Maximo = 16?
var numero_de_dentes = 8

#Numero de dentes na reserva
var numero_de_dentes_na_reserva = 0

#Fase em que o jogador está
var fase_em_que_o_jogador_esta = 0
var numero_de_waves_que_o_jogador_enfrentara = 0
var numero_de_waves_faltando = 0

#Tem o upgrade de fio dental?
var fio_dental = false

#Quantidade de pontos do jogador
var pontos = 0

#A wave ja comecou?
var spawnando = false

#A dificuldade da fase atual
var dificuldade = 1
var dificuldade_em_vetor = Vector2(1, 1)

#O modo de jogo. Pode ser 'classic', ou 'standard'
var modo = ''

#Score para ganhar mais um dente; vai sendo dobrado
var score_para_ganhar_um_dente = 1000

#Hiscore
var highscore = 0

#Tempo entre os tiros do jogador quando ele apertar e segurar o botao de ataque
var tempo_entre_tiros = 0.4

#Caminho para o savedata
const filepath = 'res://score.dat'

#Numero de pontos precisos para o proximo upgrade
var pontos_para_proximo_upgrade = 200

#Velocidadedos inimigos
var enemy_speed_multiplier = 1

#Dano dos inimigos
var enemy_damage_multiplier = 1

#Vida dos inimigos
var enemy_life_multiplier = 1

#Municao do jogador
var municao_do_jogador = 0

#Particulas
var particulas = true

#Nivel dos upgrades. Eles sao:
	#velocidade
	#chase
	#moreshots
	#dano
	#dobrarnumdentes
	#vida
	#municao
	#penetracao
	#bomba
	#shotspeed
	#miko
	#witch
	#floss
	#reset
var nivel_dos_upgrades = {
	'velocidade' : 0,
	'chase' : 0,
	'moreshots' : 0,
	'dualshot' : 0,
	'dano' : 0,
	'dobrarnumdentes' : 0,
	'vida' : 0,
	'municao' : 0,
	'penetracao' : 0,
	'bomba' : 0,
	'shotspeed' : 0,
	'miko' : 0,
	'witch' : 0,
	'floss' : 0,
	'reset' : 0
}

#E agora o nivel dos downgrades. Eles podem ser:
	#speed
	#damage
	#amount
	#life
	#damage_tooth
	#halves_tooth
	#remove_one
	#remove_three
	
var nivel_dos_downgrades = {
	'speed' : 0,
	'damage' : 0,
	'amount' : 0,
	'life' : 0,
	'damage_tooth' : 0,
	'halves_tooth' : 0,
	'remove_one' : 0,
	'remove_three' : 0
}

func _ready():
	carregar_highscore()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func game_over():
	get_tree().get_root().get_node('main_classic').print('teste')
	pass
	
func carregar_highscore():
	var arquivo = File.new()
	if not arquivo.file_exists(filepath):
		return
	
	arquivo.open(filepath, File.READ)
	highscore = arquivo.get_var()
	arquivo.close()
	
func salvar_highscore():
	var arquivo = File.new()
	arquivo.open(filepath, File.WRITE)
	arquivo.store_var(highscore)
	arquivo.close()
	
	
