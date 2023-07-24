# script to handle game state
extends Node

const DEBUG = true

enum Princess { Chessa, Sienna, Wilhelmina }
enum Category { Trivia, Location }
enum Knowledge { Known, Unknown }
enum Ending { War, Wedding, Good }

var princess_states: Dictionary = {
	Princess.Chessa: {
		Category.Trivia: Knowledge.Unknown,
		Category.Location: Knowledge.Unknown,
	},
	Princess.Sienna: {
		Category.Trivia: Knowledge.Unknown,
		Category.Location: Knowledge.Unknown,
	},
	Princess.Wilhelmina: {
		Category.Trivia: Knowledge.Unknown,
		Category.Location: Knowledge.Unknown,
	},
}

var target_princess: Princess

func get_state():
	return princess_states

func set_state(princess: Princess, category: Category):
	if not princess is Princess: return
	if not category is Category: return

	if DEBUG:
		print("[State] updating state")
		print("[State] Princess: " + str(Princess.keys()[princess]))
		print("[State] Category: " + str(Category.keys()[category]))
		print("")

	# nothing is ever gonna go from known -> unknown, so this can be a constant
	princess_states[princess][category] = Knowledge.Known

func get_ending(princess: Princess) -> Ending:
	var trivia = princess_states[princess][Category.Trivia]
	var location = princess_states[princess][Category.Location]

	if princess == Princess.Chessa and trivia == Knowledge.Known and location == Knowledge.Known:
		return Ending.Good
	elif trivia == Knowledge.Known and location == Knowledge.Known:
		return Ending.War
	else:
		return Ending.Wedding

func set_target_princess(princess):
	if not princess is Princess: return
	target_princess = princess

func get_target_princess():
	return {
		id = target_princess,
		name = Princess.keys()[target_princess]
	}
