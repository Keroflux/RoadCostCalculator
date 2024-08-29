extends Control

var num_houses := 0
var price := [496327.5, 380000.0, 381250]
var used_price := 2

var start_houses = {"11 Olsen": [0.343, 0],
				"15 Olsens nabo": [0.343, 0.05], 
				"6 Oming": [0.632, 0], 
				"14 Brekke": [0.665, 0],
				"18 Byggmester": [0.665, 0], 
				"21 Arne-Gunnar": [0.742, 0], 
				"32 Hanseth": [1.0, 0.15],
				"35 Brekke": [1.0, 0.15],
				"31 Dag-Atle + utleie": [1.0, 0.10],
				"34 Herland": [1.0, -0.1],
				"59 Vilde og Stian": [1.0, 0],
				"60 Annemor + utleie": [1.0, 0.10],
				"40 Løvås": [1.0, 0.10],
				"30 Han med hytten": [1.0, 0],
				"Dan-Egil": [0.5, 0]
				}
				
var price_per_house := 0.0
var ammont_to_split := 200.0
var tag := preload("res://HouseTag.tscn")


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
			house.house_price += unit_rest * (house.house_precent + house.house_extra_precent)
			total += house.house_price
		rest = price[used_price] - total
		
	var the_last_penny = rest / num_houses
	var tot := 0.0
	$Rest.text = str("Rest: ",the_last_penny)
	
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
		a.house_extra_precent = start_houses[house][1]
		a.get_node("Name").text = house
		a.get_node("Precent").text = str(start_houses[house][0] * 100.0)
		a.get_node("Precent2").text = str(start_houses[house][1] * 100.0)


func init_price():
	num_houses = $GridContainer.get_child_count()
	price_per_house = price[used_price] / num_houses
	for house in $GridContainer.get_children():
		house.house_price = price_per_house * (house.house_precent + house.house_extra_precent)


func _on_button_pressed():
	init_price()
	calc_price()


func reload():
	for child in $GridContainer.get_children():
		child.queue_free()
	first_init()
	init_price()
	calc_price()
