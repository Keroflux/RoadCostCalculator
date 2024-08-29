extends Panel

var house_name : String
var house_precent : float
var house_price : float
var house_extra_precent : float = 0.0


func _on_precent_text_changed(new_text):
	house_precent = float(new_text) * 0.01


func _on_button_pressed() -> void:
	var a : Dictionary = get_parent().get_parent().start_houses
	a.erase(house_name)
	get_parent().get_parent().reload()


func _on_precent_2_text_changed(new_text: String) -> void:
	house_extra_precent = float(new_text) * 0.01
