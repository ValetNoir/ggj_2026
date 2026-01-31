extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DescriptionMaker.generate_descriptions(170, 1)
	
	var similarities: int = 3

	print(DescriptionMaker.parameters_list)
	print("Possible combinations: ", DescriptionMaker.descriptions_list.size())
	print("target: ", DescriptionMaker.target_parameters)
	
	#for desc in DescriptionMaker.descriptions_list:
		#print(DescriptionMaker._get_string_from_description(desc))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
