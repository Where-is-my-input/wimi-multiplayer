extends Control
@onready var draw_progress: ProgressBar = $drawProgress
#const CARD = preload("uid://d00qkr2gh5xsc")
@onready var hand: Node = $hand
const MISSILE_CARD = preload("uid://clh46q4n6j5s6")
@onready var body: CarBodyClass = $"../Body"
const BOOST_CARD = preload("uid://c72bf0q7d52h8")
const PARRY_CARD = preload("uid://cw8e6agsvrtc1")
const BLAST_CARD = preload("uid://c7rvw6g6lxg54")
const MORTAR_CARD = preload("uid://b5kxgpasayi37")

#func _ready() -> void:
	#if !is_multiplayer_authority():
		#queue_free()

var drawnCards:int = 0

func _physics_process(_delta: float) -> void:
	addDrawProgress(0.1 * (drawnCards + 1))
	if draw_progress.value >= 100:
		setDrawProgress(0 if drawnCards < 4 else 75)
		drawCard()

func addDrawProgress(value:float = 0.1):
	draw_progress.value += value

func setDrawProgress(value:float = 100):
	draw_progress.value = value

func drawCard():
	#if hand.get_child_count() > 3: return
	if drawnCards > 3: return
	
	var c
	
	#match int(body.linear_velocity.length()) % Global.Cards.size():
	match 4:
		Global.Cards.MISSILE:
			c = MISSILE_CARD.instantiate()
		Global.Cards.BOOST:
			c = BOOST_CARD.instantiate()
		Global.Cards.PARRY:
			c = PARRY_CARD.instantiate()
		Global.Cards.BLAST:
			c = BLAST_CARD.instantiate()
		Global.Cards.MORTAR:
			c = MORTAR_CARD.instantiate()
		_:
			c = BOOST_CARD.instantiate()
	
	for child in hand.get_children():
		if child.get_child_count() <= 0:
			child.add_child(c)
			drawnCards += 1
			return

#@rpc("call_local")
func useCard(card:int = 0) -> bool:
	var cardUsed = hand.get_child(card).get_child(0)
	if cardUsed != null:
		cardUsed.activate(body)
		drawnCards -= 1
		return true
	return false
