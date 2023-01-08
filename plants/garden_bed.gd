extends StaticBody2D

const Sunflower = preload("res://plants/sunflower.tscn")
const Tomato = preload("res://plants/tomato.tscn")
const Potato = preload("res://plants/potato.tscn")
const TreePlant = preload("res://plants/tree.tscn")
const PLANTS: Array[PackedScene] = [Sunflower, Tomato, Potato, TreePlant]
const PLANT_WEIGHTS: Array[float] = [1.0, 1.0, 1.0, 0.25]

var plant_cumulative_probabilities: Array[float] = []

func _ready():
    var plant_probabilities = []
    var weight_sum = sum(PLANT_WEIGHTS)
    for wt in PLANT_WEIGHTS:
        plant_probabilities.push_back(wt / weight_sum)

    var cumulative_prob = 0.0
    for prob in plant_probabilities:
        plant_cumulative_probabilities.push_back(cumulative_prob)
        cumulative_prob += prob

    for spawn in $PlantSpawns.get_children():
        var plant = choose_plant().instantiate()
        spawn.add_child(plant)

func choose_plant():
    var f = randf()
    for i in plant_cumulative_probabilities.size():
        var p = plant_cumulative_probabilities[i]
        if f <= p:
            return PLANTS[i-1]
    return PLANTS[PLANTS.size()-1]

func sum(array: Array) -> float:
    var s = 0.0
    for value in array:
        s += value
    return s
