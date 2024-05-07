extends Panel
signal name_changed(name, node)
signal precent_changed(name)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_name_text_changed(new_text):
	emit_signal("name_changed", new_text, self)
