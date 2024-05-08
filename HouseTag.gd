extends Panel

var house_name : String
var house_precent : float
var house_price : float


func _on_precent_text_changed(new_text):
	house_precent = float(new_text) * 0.01
