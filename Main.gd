extends Control

var num_houses := 0
var price := [496327.5, 380000.0]
var used_price := 0

var start_houses = {"11": [0.343, 0],
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
	first_init()
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
		for house in $GridContainer.get_children():
			house.house_price += unit_rest * house.house_precent
			total += house.house_price
		rest = price[used_price] - total
		
	var the_last_penny = rest / num_houses
	var tot := 0.0
	
	for house in $GridContainer.get_children():
		house.house_price += the_last_penny
		house.get_node("Price").text = str(snapped(house.house_price, 0.01))
		tot += house.house_price
	$Total.text = "Sum: " + str(tot)


func first_init():
	for house in start_houses:
		var a = tag.instantiate()
		var b = tag.instantiate()
		$GridContainer.add_child(a)
		a.house_name = house
		a.house_precent = start_houses[house][0]
		a.get_node("Name").text = house
		a.get_node("Precent").text = str(start_houses[house][0] * 100.0)


func init_price():
	num_houses = $GridContainer.get_child_count()
	price_per_house = price[used_price] / num_houses
	for house in $GridContainer.get_children():
		house.house_price = price_per_house * house.house_precent


func _on_button_pressed():
	init_price()
	calc_price()
