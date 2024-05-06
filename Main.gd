extends Node2D

var num_houses := 0
var price := [496327.5, 380000.0]
var used_price := 0

var houses = {"11": [0.343, 2],
				"15": [0.343, 2], 
				"6": [0.632, 1], 
				"14": [0.665, 2],
				"18": [0.665, 2], 
				"21": [0.742, 1], 
				"32": [1.0, 9],
				"35": [1.0, 9],
				"31": [1.0, 9],
				"34": [1.0, 9],
				"59": [1.0, 9],
				"60": [1.0, 9],
				"40": [1.0, 9],
				"30": [1.0, 9],
				"Dan-Egil": [1.0, 9]
				}
				
var price_per_house := 0.0
var ammont_to_split := 2000.0
var tag = preload("res://HouseTag.tscn")

func _ready():
	init_price()
	calc()


func calc():
	var rest := 999999.9
	var total := 0.0
	var unit_price
	var unit_rest
	while rest > ammont_to_split * num_houses:
		if rest == 999999.9:
			rest = 0.0
		total = 0.0
		unit_rest = rest / num_houses
		for house in houses:
			houses[house][2] += unit_rest * houses[house][0]
			total += houses[house][2]
		rest = price[used_price] - total
	print(rest)
	var the_last_penny = rest / num_houses
	print(the_last_penny)
	for house in houses:
		houses[house][2] += the_last_penny
		var a = tag.instantiate()
		$ScrollContainer/VBoxContainer.add_child(a)
		a.get_node("Name").text = house
		a.get_node("Precent").text = str(houses[house][0])
		a.get_node("Price").text = str(snapped(houses[house][2], 0.01))
	print(houses)
	var tot := 0.0
	for house in houses:
		tot += houses[house][2]
	print(tot)


func init_price():
	num_houses = 0
	for key in houses:
		num_houses += 1
	price_per_house = price[used_price] / num_houses
	for key in houses:
		houses[key].append(price_per_house * houses[key][0])

