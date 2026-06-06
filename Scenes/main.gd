extends Control

var teams = [0, 0, 0, 0]
@export var questions: Dictionary[String, Dictionary]
var http_request: HTTPRequest
var baseurl := "https://horizons.hackclub.com/api/projects/"
var projectID := str(randi_range(0, 9000))
var url := baseurl + projectID

func _ready() -> void:
	for i in range(2):
		for idx in range(len($Center/VBox/HBoxContainer.get_children())):
			var child = $Center/VBox/HBoxContainer.get_child(idx)
			if idx < len(questions.keys()): child.name = questions.keys()[idx]
			child.find_child("Title").text = child.name.to_upper()
			for kiddo in child.get_children():
				if kiddo is Button and not kiddo.pressed.is_connected(_btn_press): kiddo.pressed.connect(_btn_press.bind(int(kiddo.name), kiddo))
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	check_url(url)

func _btn_press(score: int, btn):
	find_card(btn.get_parent().name)
	var team = 1
	teams[team - 1] += score

func find_card(type):
	if type.to_pascal_case() == "Horizons":
		var id = approvedIDs.keys().pick_random() if approvedIDs.size() > 0 else ""
		while approvedIDs.is_empty() or (id != "" and id in usedIDs):
			$Awaiting.show()
			print(testedIDs)
			if approvedIDs.size() > 0: id = approvedIDs.keys().pick_random()
			if usedIDs.size() >= approvedIDs.size(): usedIDs.clear()
			await get_tree().create_timer(0.2).timeout
		while id == "":
			print("No ID!")
			$Awaiting.show()
			print(testedIDs)
			if approvedIDs.size() > 0: id = approvedIDs.keys().pick_random()
			if usedIDs.size() >= approvedIDs.size(): usedIDs.clear()
			await get_tree().create_timer(0.2).timeout
		if not id in usedIDs: usedIDs.append(id)
		$Awaiting.hide()
		print(id, " -=- ", approvedIDs)
		print("APPROVED:\n", approvedIDs.keys(), "\n\nINVALID:\n", testedIDs.keys())
		OS.shell_open("https://horizons.hackclub.com/projects/" + id)
		return
	elif not type in questions: print("NO RELATED Qs") ; return
	var q = questions[type].keys().pick_random()
	print(q)

func check_url(ID := projectID) -> void:
	var error = http_request.request( baseurl + ID, PackedStringArray(), HTTPClient.METHOD_HEAD)
	if error != OK: print("Error sending request:", error)

var proj := ""
var testedIDs := {}
var approvedIDs := {}
var usedIDs := []
func _on_request_completed(_result: int, response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	if response_code == 404 and not projectID in testedIDs: testedIDs[projectID] = true
	else:
		if not projectID in approvedIDs: approvedIDs[projectID] = true
		proj = "https://horizons.hackclub.com/projects/" + projectID
	await get_tree().create_timer(0.1 + ((len(approvedIDs) - len(usedIDs)) / 50.0)).timeout
	print()
	projectID = str(randi_range(0, 5000))
	url = "https://horizons.hackclub.com/api/projects/%s" % projectID
	check_url()
