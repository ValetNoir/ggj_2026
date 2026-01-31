class_name DescriptionMaker

enum Parameters { SPECIES, EMOTION, PATTERN, COLOR}

static var PARAM_ENUM_SIZE: Array[int] = [
	Description.Species.size(),
	Description.Emotion.size(),
	Description.Pattern.size(),
	Description.MaskColor.size()
]
static var target_parameters: Array[int] = []
static var target_description: Description = null

static var parameters_list: Array[Array] = []
static var descriptions_list: Array[Description] = []

static func generate_descriptions(count: int, max_similarities: int) -> void:
	target_parameters = _make_random_parameters()
	target_description = _make_description_from_parameters(target_parameters)
	_generate_all_possible_parameters()
	_filter_parameters_list(max_similarities)
	parameters_list.shuffle()
	if parameters_list.size() > count:
		parameters_list.resize(count)
	descriptions_list.clear()
	for param in parameters_list:
		descriptions_list.append(_make_description_from_parameters(param))

static func _make_description_from_parameters(parameters: Array[int]) -> Description:
	assert(parameters.size() >= Parameters.size(), "Tried to make description from too few parameters")
	var description := Description.new()
	description.species = parameters[Parameters.SPECIES]
	description.emotion = parameters[Parameters.EMOTION]
	description.pattern = parameters[Parameters.PATTERN]
	description.color = parameters[Parameters.COLOR]
	return description

static func _get_string_from_description(desc: Description) -> String:
	var result = "[%d, %d, %d ,%d]" % [desc.species, desc.emotion, desc.pattern, desc.color]
	
	return result

static func _make_array_from_description(description: Description) -> Array[int]:
	var result: Array[int] = []
	result.resize(Parameters.size())
	result[Parameters.SPECIES] = description.species
	result[Parameters.EMOTION] = description.emotion
	result[Parameters.PATTERN] = description.pattern
	result[Parameters.COLOR] = description.color
	return result

static func _generate_all_possible_parameters() -> void:
	parameters_list.clear()
	var current_parameters: Array[int] = []
	var max_count: int = 1
	for i in Parameters.size():
		current_parameters.push_back(0)
		max_count *= PARAM_ENUM_SIZE[i]
	
	for current_id in max_count:
		parameters_list.push_back(current_parameters.duplicate())
		_increment_parameter_array(current_parameters)
		
static func _filter_parameters_list(max_similarities: int) -> void:
	parameters_list = parameters_list.filter(
		func(param): return _count_similarities(param, target_parameters) <= max_similarities
	)

static func _count_similarities(current: Array[int], target: Array[int]) -> int:
	assert(current.size() == target.size(), "Can't compare arrays of different sizes.")
	var similarities: int = 0
	for i in current.size():
		if current[i] == target[i]:
			similarities += 1
	return similarities

static func _increment_parameter_array(array: Array[int]) -> void:
	var current_id: int = 0
	while current_id < array.size():
		array[current_id] += 1
		if array[current_id] >= PARAM_ENUM_SIZE[current_id]:
			array[current_id] = 0
			current_id += 1
		else:
			break

static func _make_random_parameters() -> Array[int]:
	var parameters: Array[int] = []
	for param in Parameters.size():
		parameters.push_back(randi_range(0, PARAM_ENUM_SIZE[param] - 1))
	return parameters
