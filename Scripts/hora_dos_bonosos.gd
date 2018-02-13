extends Control

#Variaveis!
#Estilo das arrays da array de upgrade:
	#ID
	#Nome
	#Descricao
	#Nome do upgrade
#Nomes possiveis:
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
	
	
var lista_de_upgrades = [
	[0, 'Sprite Trail', "Because it's cool as heck. Oh, and makes you faster.", 'velocidade'],
	[1, 'Nitro toothpaste', "Makes you even faster.", 'velocidade'],
#	[2, 'Chaser Bullets', 'Your shots follow the foods. Makes aiming kinda pointless.', 'chase'],
	[3, 'Double Shot', 'Trade damage for coverage: your shots go in a "V" shape. Beware the space in the middle!', 'moreshots'],
	[4, 'Triple Shot', "Sacrifice shot damage for coverage. Your shots go straight AND in a V shape.", 'moreshots'],
	[5, 'Bottom Lid', 'Shoot bullets to the front and backwards. Also slightly lowers your damage.', 'dualshot'],
	[6, 'Minor refrescancy', 'Increases your shots damage. Nothing too fancy.', 'dano'],
	[7, 'Major refrescancy', 'Increases your shots damage (and "cool" level) more. Now this is fancy!', 'dano'],
	[8, 'Greater refrescancy', 'Increases your shots damage even more, and makes them cool at a glacial level.', 'dano'],
	[9, 'Ultimate refrescancy', "Your shots now have a temperature of negative Kelvin... curiously, it doesn't freeze the mouth.", 'dano'],
	[10, 'New Denture', "Doubles your tooth amount. If they are real, that's another story...", 'dobrarnumdentes'],
	[11, 'Tooth whitening', "Gives your teeth a shield, and we know this doesn't make any sense.", 'vida'],
	[12, 'Calcium coating', "More teeth health.", 'vida'],
	[13, 'Titanium coating', "More teeth health. Now you might stand a chance.", 'vida'],
	[14, 'Gold coating', "What the... well, increases your bling. Yo. Oh, and health too.", 'vida'],
#	[15, 'Double Ammo', "Change the toothpaste formulae to get double the paste on the same volume.", 'municao'],
#	[16, 'Quadruple Ammo', "Break the rules of space and time to get double the paste on half the volume.", 'municao'],
#	[17, 'Infinite Ammo', "Get your toothpaste directly from the Toothpaste Dimension.", 'municao'],
	[18, 'Strawberry Flavor', "Your shots survive killing a single food.", 'penetracao'],
	[19, 'Mint Flavor', "Your shots survive killing two  foods.", 'penetracao'],
	[20, 'Full Meal Flavor', "Yep. One shot, three kills.", 'penetracao'],
	[21, 'Bigger Mouthwash', "Bigger bomb bag... err, I mean, maximum bombs +1.", 'bomba'],
#	[22, 'Mouthwash Bucket', "Bombs accumulate between waves.", 'bomba'],
	[23, "Using H2SO4 as mouthwash", "Usually not a good idea. Grants a bigger bomb maximum.", 'bomba'], # "Cleans so much that also heals your teeth. Obvious alert: do not try this.", 'bomba'],
	[24, 'Quick press', "Shoot faster.", 'shotspeed'],
	[25, 'Quicker press', 'SHOOT FASTER.', 'shotspeed'],
	[26, 'Fast press', 'Gotta shoot fast.', 'shotspeed'],
	[27, 'Faster press', 'Too fast for you.', 'shotspeed'],
	[28, 'Fastest press on the west', 'Who needs turbo buttons, am I right?', 'shotspeed'],
	[29, 'Miko thing', "A stick with papers on an end. Scares bad spirits. Foods as well. Lowers the amount of enemies.", 'miko'],
	[30, 'Witch hat', 'An excessively big black witch hat. Gives you the magic "Master Love Rainbow Toothpaste". Bigger shots.', 'witch'],
#	[31, 'Tooth floss', "Stronger teeth! Every wave beginning, they are healed.", 'floss'],
	[32, 'Change human', "Game got too hard for you? Fear no more: now you can keep your score and go back to the begin of the game.", 'reset']
]

var upgrades_de_velocidade = [0, 1]
var upgrades_de_dano = [6, 7, 8, 9]
var upgrades_de_vida = [11, 12, 13,14]
var upgrades_de_municao = [15, 16, 17]
var upgrades_de_penetracao = [18,19,20]
var upgrades_de_bomba = [21, 22, 23]
var upgrades_de_shotspeed = [24, 25, 26, 27, 28]

#Estilo das arrays da array de downgrade:
	#ID
	#Nome
	#Descricao
	#Nome do downgrade
#Nomes possiveis:
	#speed
	#damage
	#amount
	#life
	#damage_tooth
	#halves_tooth
	#remove_one
	#remove_three

var lista_de_downgrades = [
	[0, 'Mc King', 'Faster food.', 'speed'],
	[1, "Donald's Burger", 'Even faster food.', 'speed'],
	[2, 'Light coated', "Need for fast. This food simply can't go faster.", 'speed'],
	[3, 'Now with more chemicals!', "More food damage.", 'damage'],
	[4, 'Fermented', "Wines get better with age, why not all foods? Even more food damage.", 'damage'],
	[5, 'Infected Toadstools', "Vicious and delicious. Eww...greater food damage.", 'damage'],
	[6, "Rot 'n Roll", "The food is just kinda zombified at this point. Gigantifies its damage.", 'damage'],
	[7, 'Tooth-fairy deal', "More food.", 'amount'],
	[8, "Transgenic methods", "Even more food.", 'amount'],
	[9, "Biotechnology + Food Engineering", "No one should have hunger with this much food.", 'amount'],
	[10, 'We are alive', "Yet again, more food.", 'amount'],
	[11, "Food master race", "Now food just dominates the planet I guess.", 'amount'],
	[12, "Teeth are food for food", "Good luck.", 'amount'],
	[13, "100% Food Fiber Free", "Doubles food life.", 'life'],
	[14, "Extra trans fat", "Doubles food life (again). Take care!", 'life'],
	[15, "New Plastic Flavor", "100% NOT biodegradable. More food life.", 'life'],
	[16, "The Hunger Aniquilator", "Almost indestructible food... Kinda.", 'life'],
#	[17, "Tingling sensation", "Damages all your tooth.", 'damage_tooth'],
	[18, "Coming like a punch", "Halves your number of tooth.", 'halves_tooth'],
	[19, "Industry saboutage", "Randomly removes one of your upgrades.", 'remove_one'],
	[20, "Food that does not feed", "Randomly removes three of your upgrades.", 'remove_three']#,
#	[21, 'For travel', 'Makes food smaller.', 'food_size'],
#	[22, 'Pocket size', 'Makes food yet smaller.', "food_size"],
#	[23, 'Future food', 'You will have a tough time hitting these.', 'food_size']
]

var downgrades_de_velocidade = [0, 1, 2]
var downgrades_de_dano = [3, 4, 5, 6, 12]
var downgrades_de_quantidade = [7, 8, 9, 10, 11]
var downgrades_de_vida = [13, 14, 15, 16]

var lista_de_opcoes = []

var nome_do_upgrade_da_vez = ''
var descricao_do_upgrade_da_vez = ''
var upgrade_da_vez = ''

var nome_do_downgrade_da_vez = ''
var descricao_do_downgrade_da_vez = ''
var downgrade_da_vez = ''

var selecionado = 0

onready var opcao_de_bonus_preload = preload('res://Scenes/opcao_de_bonus.tscn')

var as_tres_opcoes_da_vez = []

var modo = 'vermelho'
var cor_atual = Color(1, 0, 0)
var velocidade_da_mudanca_de_cor = 0.1

var escolheu = false

func _ready():
	set_process(true)
	_gerar_primeiro_bonus()
	_gerar_segundo_bonus()
	_gerar_terceiro_bonus()
	lista_de_opcoes = as_tres_opcoes_da_vez
	pass

func _process(delta):
	if modo == 'vermelho':
		cor_atual.g += velocidade_da_mudanca_de_cor
		cor_atual.b -= velocidade_da_mudanca_de_cor
		if cor_atual.g >= 1:
			modo = 'verde'
	elif modo == 'verde':
		cor_atual.b += velocidade_da_mudanca_de_cor
		cor_atual.r -= velocidade_da_mudanca_de_cor
		if cor_atual.b >= 1:
			modo = 'azul'
	elif modo == 'azul':
		cor_atual.r += velocidade_da_mudanca_de_cor
		cor_atual.g -= velocidade_da_mudanca_de_cor
		if cor_atual.r >= 1:
			modo = 'vermelho'
	$Position2D/selecao.set_modulate(cor_atual)
#	$MarginContainer2/Panel.set_modulate(cor_atual)
	
	if Input.is_action_just_pressed('ui_right'):
		selecionado += 1
		$AudioStreamPlayer.play()
	if Input.is_action_just_pressed('ui_left'):
		selecionado -= 1
		$AudioStreamPlayer.play()
	
	if selecionado > lista_de_opcoes.size() - 1:
		selecionado = 0
	if selecionado < 0:
		selecionado = lista_de_opcoes.size() -1 
	
	$Position2D.global_position.x = selecionado * 250
	
	if (Input.is_action_just_pressed('ui_accept') or Input.is_action_just_pressed('ui_attack')) and not escolheu and not $AnimationPlayer.is_playing():
#		set_process(false)
		escolheu = true
		$AudioStreamPlayer.play()
		yield(get_tree().create_timer(0.075), 'timeout')
		$AudioStreamPlayer2.play()
		if selecionado == 0:
			_bonus_um_escolhido()
		elif selecionado == 1:
			_bonus_dois_escolhido()
		elif selecionado == 2:
			_bonus_tres_escolhido()
#		var funcao = funcref(self, lista_de_opcoes[selecionado][0])
#		funcao.call_func()
	
	pass

func _gerar_primeiro_bonus():
	randomize()
	_escolher_upgrade()
	_escolher_downgrade()
	
	var opcao_de_bonus = opcao_de_bonus_preload.instance()
	opcao_de_bonus.get_node('UpgradeNome').set_text(nome_do_upgrade_da_vez)
	opcao_de_bonus.get_node('UpgradeDescricao').set_text(descricao_do_upgrade_da_vez)
	opcao_de_bonus.get_node('DowngradeNome').set_text(nome_do_downgrade_da_vez)
	opcao_de_bonus.get_node('DowngradeDescricao').set_text(descricao_do_downgrade_da_vez)
	
	opcao_de_bonus.get_node('Button').connect('pressed', get_tree().get_nodes_in_group('bonosos_manager')[0], '_bonus_um_escolhido')
	
#	get_node('MarginContainer/HBoxContainer').add_child(opcao_de_bonus)
	get_node('MarginContainer/HBoxContainer').add_child(opcao_de_bonus)
	as_tres_opcoes_da_vez.append([upgrade_da_vez, downgrade_da_vez])
	pass

func _gerar_segundo_bonus():
	randomize()
	_escolher_upgrade()
	_escolher_downgrade()
	
	var opcao_de_bonus = opcao_de_bonus_preload.instance()
	opcao_de_bonus.get_node('UpgradeNome').set_text(nome_do_upgrade_da_vez)
	opcao_de_bonus.get_node('UpgradeDescricao').set_text(descricao_do_upgrade_da_vez)
	opcao_de_bonus.get_node('DowngradeNome').set_text(nome_do_downgrade_da_vez)
	opcao_de_bonus.get_node('DowngradeDescricao').set_text(descricao_do_downgrade_da_vez)
	
	opcao_de_bonus.get_node('Button').connect('pressed', get_tree().get_nodes_in_group('bonosos_manager')[0], '_bonus_dois_escolhido')
	
	get_node('MarginContainer/HBoxContainer').add_child(opcao_de_bonus)
	as_tres_opcoes_da_vez.append([upgrade_da_vez, downgrade_da_vez])
	pass

func _gerar_terceiro_bonus():
	randomize()
	_escolher_upgrade()
	_escolher_downgrade()
	
	var opcao_de_bonus = opcao_de_bonus_preload.instance()
	opcao_de_bonus.get_node('UpgradeNome').set_text(nome_do_upgrade_da_vez)
	opcao_de_bonus.get_node('UpgradeDescricao').set_text(descricao_do_upgrade_da_vez)
	opcao_de_bonus.get_node('DowngradeNome').set_text(nome_do_downgrade_da_vez)
	opcao_de_bonus.get_node('DowngradeDescricao').set_text(descricao_do_downgrade_da_vez)
	
	opcao_de_bonus.get_node('Button').connect('pressed', get_tree().get_nodes_in_group('bonosos_manager')[0], '_bonus_tres_escolhido')
	
	get_node('MarginContainer/HBoxContainer').add_child(opcao_de_bonus)
	as_tres_opcoes_da_vez.append([upgrade_da_vez, downgrade_da_vez])
	pass

func _bonus_um_escolhido():
	print('1')
#	var upgrade = as_tres_opcoes_da_vez[0][0]
#	var downgrade = as_tres_opcoes_da_vez[0][1]
	var upgrade = funcref(self, as_tres_opcoes_da_vez[0][0])
	var downgrade = funcref(self, as_tres_opcoes_da_vez[0][1])
	upgrade.call_func()
	downgrade.call_func()
	$AnimationPlayer.play('slide_out')
	get_tree().set_pause(false)
	get_tree().get_current_scene()._initiate_wave()

func _bonus_dois_escolhido():
	print('2')
#	var upgrade = as_tres_opcoes_da_vez[1][0]
#	var downgrade = as_tres_opcoes_da_vez[1][1]
	var upgrade = funcref(self, as_tres_opcoes_da_vez[1][0])
	var downgrade = funcref(self, as_tres_opcoes_da_vez[1][1])
	upgrade.call_func()
	downgrade.call_func()
	$AnimationPlayer.play('slide_out')
	get_tree().set_pause(false)
	get_tree().get_current_scene()._initiate_wave()
	
func _bonus_tres_escolhido():
	print('3')
#	var upgrade = as_tres_opcoes_da_vez[2][0]
#	var downgrade = as_tres_opcoes_da_vez[2][1]
	var upgrade = funcref(self, as_tres_opcoes_da_vez[2][0])
	var downgrade = funcref(self, as_tres_opcoes_da_vez[2][1])
	upgrade.call_func()
	downgrade.call_func()
	$AnimationPlayer.play('slide_out')
	get_tree().set_pause(false)
	get_tree().get_current_scene()._initiate_wave()


func _escolher_upgrade():
#	var id = rand_range(0, lista_de_upgrades.size())
	var id = randi() % (lista_de_upgrades.size())# + 1)
#	var id = 6
	upgrade_da_vez = lista_de_upgrades[id][3]
	
	var lista_de_upgrades_desse_tipo = []
	for upgrade in lista_de_upgrades:
		if upgrade[3] == upgrade_da_vez:
			lista_de_upgrades_desse_tipo.append(upgrade)
	
	if (global.nivel_dos_upgrades[lista_de_upgrades[id][3]] > lista_de_upgrades_desse_tipo.size() - 1) or (upgrade_da_vez == 'reset' and global.fase_em_que_o_jogador_esta <= 10):
		_escolher_upgrade()
		return
	
	var upgrade_a_ser_oferecido = lista_de_upgrades_desse_tipo[global.nivel_dos_upgrades[lista_de_upgrades[id][3]]]
	
	nome_do_upgrade_da_vez = lista_de_upgrades_desse_tipo[global.nivel_dos_upgrades[upgrade_da_vez]][1]
	descricao_do_upgrade_da_vez = lista_de_upgrades_desse_tipo[global.nivel_dos_upgrades[upgrade_da_vez]][2]
	upgrade_da_vez = lista_de_upgrades_desse_tipo[global.nivel_dos_upgrades[upgrade_da_vez]][3]
#	print(str(lista_de_upgrades_desse_tipo))
#	global.nivel_dos_upgrades[lista_de_upgrades[id][3]]


#
#	nome_do_upgrade_da_vez = lista_de_upgrades[id][1]
#	descricao_do_upgrade_da_vez = lista_de_upgrades[id][2]
#
#
#
#	print(upgrade_da_vez)
#	if id in upgrades_de_velocidade:
#		upgrade_da_vez = 'velocidade'
#	elif id in upgrades_de_dano:
#		upgrade_da_vez = 'dano' 
#	elif id in upgrades_de_vida:
#		upgrade_da_vez = 'vida'
#	elif id in upgrades_de_municao:
#		upgrade_da_vez = 'municao'
#	elif id in upgrades_de_penetracao:
#		upgrade_da_vez = 'penetracao'
#	elif id in upgrades_de_bomba:
#		upgrade_da_vez = 'bomba'
#	elif id in upgrades_de_shotspeed:
#		upgrade_da_vez = 'shotspeed'
#	elif id == 2:
#		upgrade_da_vez = ''
#	elif id == 3:
#		upgrade_da_vez = ''
#	elif id == 4:
#		upgrade_da_vez = ''
#	elif id == 5:
#		upgrade_da_vez = ''
#	elif id == 10:
#		upgrade_da_vez = ''
#	elif id == 29:
#		upgrade_da_vez = ''
#	elif id == 30:
#		upgrade_da_vez = ''
#	elif id == 31:
#		upgrade_da_vez = ''
#	elif id == 32:
#		upgrade_da_vez = ''
	
	pass
	
func _escolher_downgrade():
	#Pega um indice aleatorio entre os possiveis da lista de downgrades
	var id = randi() % (lista_de_downgrades.size())
	#A partir do indice aleatorio, indentifica o downgrade da vez, pois a 3a entrada da array deste
	#downgrade em particular e o nome do tipo de downgrade
	downgrade_da_vez = lista_de_downgrades[id][3]
	if (downgrade_da_vez == 'remove_one' or downgrade_da_vez == 'remove_three') and global.fase_em_que_o_jogador_esta < 5:
		_escolher_downgrade()
		return
	#Agora faz-se uma lista com todos os upgrades deste tipo
	var lista_de_downgrades_desse_tipo = []
	for downgrade in lista_de_downgrades:
		if downgrade[3] == downgrade_da_vez:
			lista_de_downgrades_desse_tipo.append(downgrade)
	
	if global.nivel_dos_downgrades[lista_de_downgrades[id][3]] > lista_de_downgrades_desse_tipo.size() - 1:
		_escolher_downgrade()
		return
	
	var downgrade_a_ser_oferecido = lista_de_downgrades_desse_tipo[global.nivel_dos_downgrades[lista_de_downgrades[id][3]]]

	nome_do_downgrade_da_vez = lista_de_downgrades_desse_tipo[global.nivel_dos_downgrades[downgrade_da_vez]][1]
	descricao_do_downgrade_da_vez = lista_de_downgrades_desse_tipo[global.nivel_dos_downgrades[downgrade_da_vez]][2]
	downgrade_da_vez = lista_de_downgrades_desse_tipo[global.nivel_dos_downgrades[downgrade_da_vez]][3]

#	nome_do_downgrade_da_vez = lista_de_downgrades[id][1]
#	descricao_do_downgrade_da_vez = lista_de_downgrades[id][2]
#	downgrade_da_vez = lista_de_downgrades[id][3]

#
#func _speed_up():
#	var nome = lista_de_upgrades[0][1]
#	var descricao = lista_de_upgrades[0][2]
#	print(nome + descricao)
#
	
### Funcoes dos upgrades ###

func velocidade():
	global.velocidade_maxima_do_jogador *= 2
	global.nivel_dos_upgrades['velocidade'] += 1
	print(str(global.velocidade_maxima_do_jogador))
	pass
	
func chase():
	global.tipo_do_tiro = 'chase'
	global.nivel_dos_upgrades['chase'] += 1
	pass
	
func moreshots():
#	global.tipo_do_tiro = 'chase'
	global.nivel_dos_upgrades['moreshots'] += 1
	global.dano_do_jogador *= 0.60
	pass
	
func dualshot():
	global.nivel_dos_upgrades['dualshot'] += 1
	global.dano_do_jogador *= 0.85
	
func dano():
	global.dano_do_jogador *= 1.75
	global.nivel_dos_upgrades['dano'] += 1
	pass
	
func dobrarnumdentes():
	global.numero_de_dentes *= 2
	global.numero_de_dentes_na_reserva *= 2
	global.nivel_dos_upgrades['dobrarnumdentes'] += 1
	
	while global.numero_de_dentes > 16:
		global.numero_de_dentes -= 1
		global.numero_de_dentes_na_reserva += 1

	while (global.numero_de_dentes_na_reserva > 0 and global.numero_de_dentes < 16):
		global.numero_de_dentes += 1
		global.numero_de_dentes_na_reserva -= 1
	
	pass
	
func vida():
	global.vida_do_dente *= 2
	global.nivel_dos_upgrades['vida'] += 1
	pass
	
func municao():
	global.municao_maxima_do_jogador *= 2
	global.nivel_dos_upgrades['municao'] += 1
	pass
	
func penetracao():
	global.vida_do_tiro += 1
	global.nivel_dos_upgrades['penetracao'] += 1
	pass
	
func bomba():
	global.numero_de_bombas_do_jogador += 1
	global.numero_de_bombas_que_o_jogador_tem += 1
	global.nivel_dos_upgrades['bomba'] += 1
	pass
	
func shotspeed():
#	global.velocidade_do_tiro *= 2
	global.tempo_entre_tiros *= 0.7
	global.nivel_dos_upgrades['shotspeed'] += 1
	pass
	
func miko():
	global.numero_de_waves_que_o_jogador_enfrentara *= 0.5
	global.nivel_dos_upgrades['miko'] += 1
	pass
	
func witch():
	global.tipo_do_tiro = 'chase'
	global.nivel_dos_upgrades['witch'] += 1
	pass
	
func floss():
	global.fio_dental = true
	global.nivel_dos_upgrades['floss'] += 1
	pass
	
func reset():
	for entrada in global.nivel_dos_upgrades:
		global.nivel_dos_upgrades[entrada] = 0
	for entrada in global.nivel_dos_downgrades:
		global.nivel_dos_downgrades[entrada] = 0
	
	global.dano_do_jogador = 1
	global.velocidade_do_tiro = 0.8
	global.numero_de_bombas_do_jogador = 2
	global.numero_de_bombas_que_o_jogador_tem = 0
	global.vida_do_dente = 2
	global.vida_do_tiro = 1
	global.municao_maxima_do_jogador = 150
	global.tipo_do_tiro = 'normal'
	global.velocidade_maxima_do_jogador = 200
	global.numero_de_dentes = 8
	global.numero_de_dentes_na_reserva = 0
	global.fase_em_que_o_jogador_esta = 0
	global.numero_de_waves_que_o_jogador_enfrentara = 0
	global.numero_de_waves_faltando = 0
	global.fio_dental = false
	global.spawnando = false
	global.dificuldade = 1
	global.dificuldade_em_vetor = Vector2(1, 1)
	global.modo = ''
	global.score_para_ganhar_um_dente = 1000
	global.tempo_entre_tiros = 0.4
	global.pontos_para_proximo_upgrade = 200
	global.enemy_speed_multiplier = 1
	global.enemy_damage_multiplier = 1
	global.enemy_life_multiplier = 1
	global.municao_do_jogador = 0
	global.fase_em_que_o_jogador_esta = 0
	global.numero_de_waves_que_o_jogador_enfrentara = 0
	global.numero_de_waves_faltando = 0
	global.dificuldade = 1
	global.fase_em_que_o_jogador_esta = 0
	global.nivel_dos_upgrades['reset'] += 1
	pass
	
### Funcoes dos downgrades ###
	
func speed():
	global.enemy_speed_multiplier *= 2
	global.nivel_dos_downgrades['speed'] += 1
	pass
	
func damage():
	global.enemy_damage_multiplier *= 2
	global.nivel_dos_downgrades['damage'] += 1
	pass
	
func amount():
	global.numero_de_waves_que_o_jogador_enfrentara *= 2
	global.nivel_dos_downgrades['amount'] += 1
	pass
	
func life():
	global.enemy_life_multiplier *= 2
	global.nivel_dos_downgrades['life'] += 1
	pass
	
func damage_tooth():
#	global.tipo_do_tiro = 'chase'
	for dente in get_tree().get_nodes_in_group('tooth'):
		dente._levar_dano(round(dente.vida * 0.5))
	
	global.nivel_dos_downgrades['damage_tooth'] += 1
	pass
	
func halves_tooth():
	global.numero_de_dentes_na_reserva = round(0.5*global.numero_de_dentes_na_reserva)
	global.numero_de_dentes = round(0.5*global.numero_de_dentes)
	global.nivel_dos_downgrades['halves_tooth'] += 1
	pass
	
func remove_one():
	global.nivel_dos_upgrades[randi() % global.nivel_dos_upgrades.size()] = 0
	global.nivel_dos_downgrades['remove_one'] += 1
	pass
	
func remove_three():
	global.nivel_dos_upgrades[randi() % global.nivel_dos_upgrades.size()] = 0
	global.nivel_dos_upgrades[randi() % global.nivel_dos_upgrades.size()] = 0
	global.nivel_dos_upgrades[randi() % global.nivel_dos_upgrades.size()] = 0
	global.nivel_dos_downgrades['remove_three'] += 1
	pass

func _on_AnimationPlayer_animation_finished( anim_name ):
	if anim_name == 'slide_out':
		self.queue_free()
	pass # replace with function body
