# script to handle game state

enum Princess { Chessa, Sienna, Wilhelmina }
enum Category { Trivia, Location }
enum State { Known, Unknown }

var princess_states: Dictionary = {
    [Princess.Chessa]: {
        [Category.Trivia]: State.Unknown,
        [Category.Location]: State.Unknown,
    },
    [Princess.Sienna]: {
        [Category.Trivia]: State.Unknown,
        [Category.Location]: State.Unknown,
    },
    [Princess.Wilhelmina]: {
        [Category.Trivia]: State.Unknown,
        [Category.Location]: State.Unknown,
    },
}

func get_state():
    return princess_states

func set_state(princess: Princess, category: Category, state: State):
    if not princess is Princess: return
    if not category is Category: return
    if not state is State: return

    princess_states[princess][category] = state
