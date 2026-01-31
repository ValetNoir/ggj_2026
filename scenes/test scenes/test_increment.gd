extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DescriptionMaker.generate_descriptions(20, 0)
	
	var similarities: int = 1
	DescriptionMaker._filter_parameters_list(1)
	print(DescriptionMaker.parameters_list)
	print("Possible combinations: ", DescriptionMaker.descriptions_list.size())
	print("target: ", DescriptionMaker.target_parameters)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
