# script to handle game state
extends Node

const DEBUG = true

enum Princess { Chessa, Sienna, Wilhelmina }
enum Category { Trivia, Location }
enum Knowledge { Known, Unknown }

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
