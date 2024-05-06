extends Node2D

var num_houses := 0
var price := [496327.5, 380000.0]
var used_price := 0
var houses = {"15/11": [0.343, 2], 
				"6": [0.632, 1], 
				"14/18": [0.665, 2], 
				"21": [0.742, 1], 
				"Toppen": [1.0, 9], 
				"Mest": [1.3, 0]}
var price_per_house := 0.0
var ammont_to_split := 5000.0

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
			total += houses[house][2] * houses[house][1]
		rest = price[used_price] - total
	print(rest)
	var the_last_penny = rest / num_houses
	print(the_last_penny)
	for house in houses:
		houses[house][2] += the_last_penny
	print(houses)
	var tot := 0.0
	for house in houses:
		tot += houses[house][2] * houses[house][1]
	print(tot)


func init_price():
	for key in houses:
		num_houses += houses[key][1]
	price_per_house = price[used_price] / num_houses
	for key in houses:
		houses[key].append(price_per_house * houses[key][0])

