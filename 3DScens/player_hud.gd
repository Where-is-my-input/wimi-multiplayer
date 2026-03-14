extends Control
@onready var draw_progress: ProgressBar = $drawProgress
#const CARD = preload("uid://d00qkr2gh5xsc")
@onready var hand: HBoxContainer = $hand
const MISSILE_CARD = preload("uid://clh46q4n6j5s6")
@onready var body: CarBodyClass = $"../Body"
const BOOST_CARD = preload("uid://c72bf0q7d52h8")
const PARRY_CARD = preload("uid://cw8e6agsvrtc1")

#func _ready() -> void:
	#if !is_multiplayer_authority():
		#queue_free()

func _physics_process(_delta: float) -> void:
	addDrawProgress(0.1 * (hand.get_child_count() + 1))
	if draw_progress.value >= 100:
		setDrawProgress(0 if hand.get_child_count() < 4 else 75)
		drawCard()

func addDrawProgress(value:float = 0.1):
	draw_progress.value += value

func setDrawProgress(value:float = 100):
	draw_progress.value = value

func drawCard():
	if hand.get_child_count() > 3: return
	
	var c
	
	match int(body.linear_velocity.length()) % 3:
		Global.Spells.MISSILE:
			c = MISSILE_CARD.instantiate()
		Global.Spells.BOOST:
			c = BOOST_CARD.instantiate()
		Global.Spells.PARRY:
			c = PARRY_CARD.instantiate()
		_:
			c = BOOST_CARD.instantiate()
	hand.add_child(c)

@rpc("call_local")
func useCard(card:int = 0) -> bool:
	var cardUsed = hand.get_child(card)
	if cardUsed != null:
		cardUsed.activate(body)
		return true
	return false
