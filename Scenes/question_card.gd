extends Control

signal team(team)

func enter(question, subject):
	$Panel/VBoxContainer/Topic.text = "TOPIC: " + subject
	$Panel/VBoxContainer/Question.text = question
	$Panel/VBoxContainer/Answer.text = get_parent().questions[subject][question]
	$AnimationPlayer.play("enter")

func _on_option_pressed() -> void:
	$AnimationPlayer.play("exit")
	$Panel2.show()
	await $Panel2/VBoxContainer/Submit.pressed
	team.emit($Panel2/VBoxContainer/OptionButton.get_selected_id())
	queue_free()

func _on_reveal_pressed() -> void:
	$Panel/VBoxContainer/Answer.show()
	$Panel/VBoxContainer/Buttons.show()
	$Panel/VBoxContainer/Reveal.hide()
