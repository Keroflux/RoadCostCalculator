extends Node2D

var num_houses := 0
var price := [496327.5, 380000.0]
var used_price := 0

var houses = {"11": [0.343, 0],
				"15": [0.343, 0], 
				"6": [0.632, 0], 
				"14": [0.665, 0],
				"18": [0.665, 0], 
				"21": [0.742, 0], 
				"32": [1.0, 0],
				"35": [1.0, 0],
				"31": [1.0, 0],
				"34": [1.0, 0],
				"59": [1.0, 0],
				"60": [1.0, 0],
				"40": [1.0, 0],
				"30": [1.0, 0],
				"Dan-Egil": [0.5, 0]
				}
				
var price_per_house := 0.0
var ammont_to_split := 2000.0
var tag = preload("res://HouseTag.tscn")

func _ready():
	init_price()
	calc_price()


func calc_price():
	var rest := 999999.9
	var total := 0.0
	var unit_rest
	while rest > ammont_to_split * num_houses:
		if rest == 999999.9:
			rest = 0.0
		total = 0.0
		unit_rest = rest / num_houses
		for house in houses:
			houses[house][1] += unit_rest * houses[house][0]
			total += houses[house][1]
		rest = price[used_price] - total
	var the_last_penny = rest / num_houses
	for house in houses:
		houses[house][1] += the_last_penny
		var a = tag.instantiate()
		$ScrollContainer/VBoxContainer.add_child(a)
		a.get_node("Name").text = house
		a.name = house
		a.name_changed.connect(rename)
		a.get_node("Precent").text = str(houses[house][0] * 100.0)
		a.get_node("Price").text = str(snapped(houses[house][1], 0.01))
	var tot := 0.0
	for house in houses:
		tot += houses[house][1]


func init_price():
	num_houses = 0
	for child in $ScrollContainer/VBoxContainer.get_children():
		child.queue_free()
	for key in houses:
		num_houses += 1
	price_per_house = price[used_price] / num_houses
	for key in houses:
		houses[key][1] = price_per_house * houses[key][0]


func rename(name, from):
	print(name)


func _on_button_pressed():
	init_price()
	calc_price()
