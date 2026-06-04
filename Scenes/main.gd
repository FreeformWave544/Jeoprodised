extends Control

var teams = [0, 0, 0, 0]
@export var questions: Dictionary[String, Dictionary]

func _ready() -> void:
	for i in range(2):
		for idx in range(len($Center/VBox/HBoxContainer.get_children())):
			var child = $Center/VBox/HBoxContainer.get_child(idx)
			if idx < len(questions.keys()): child.name = questions.keys()[idx]
			child.find_child("Title").text = child.name.to_upper()
			for kiddo in child.get_children():
				if kiddo is Button and not kiddo.pressed.is_connected(_btn_press): kiddo.pressed.connect(_btn_press.bind(int(kiddo.name), kiddo))

func _btn_press(score: int, btn):
	find_card(btn.get_parent().name)
	var team = 1
	teams[team - 1] += score

func find_card(type):
	if not type in questions: print("NO RELATED Qs") ; return
	var q = questions[type].keys().pick_random()
	print(q)
