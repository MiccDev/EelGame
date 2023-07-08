extends Node

func get_nodes_in_radius(origin: Vector2, radius: int, group: String = ""):
	var nodes_within_radius: Array[Node2D] = []
	for node in get_all_tree_nodes():
		if not is_instance_of(node, Node2D): 
			continue
		if origin.distance_squared_to(node.position) <= radius ** 2:
			if group != "" and not node.is_in_group(group):
				continue
			nodes_within_radius.append(node)
	return nodes_within_radius

func get_all_tree_nodes(node = get_tree().root, listOfAllNodesInTree: Array[Node2D] = []):
	listOfAllNodesInTree.append(node)
	for childNode in node.get_children():
		get_all_tree_nodes(childNode, listOfAllNodesInTree)
	return listOfAllNodesInTree
