extends Control

var teams = [0, 0, 0, 0]
@export var questions: Dictionary[String, Dictionary] = {
	"Abortion": {
		"Up until how long is abortion legal in the UK?": "24 weeks.",
		"When was abortion legalised in the UK?": "1967.",
		"How many doctors must agree before an abortion can take place?": "Two doctors.",
		"Does the father get a legal say in an abortion?": "No.",
		"What does sanctity of life teach about abortion?": "Life is sacred and belongs to God.",
		"What does Situation Ethics teach about abortion?": "Do the most loving thing.",
		"What is a Christian argument for abortion in cases of rape?": "Situation Ethics teaches doing the most loving thing.",
		"What is a Christian argument for abortion if the mother's life is at risk?": "It may be the lesser of two evils.",
		"What is a Christian argument for abortion in cases of severe disability?": "Quality of life should be considered.",
		"What is a Christian argument against abortion?": "Life begins at conception and the baby has a soul.",
		"Why do some Christians believe abortion is murder?": "The baby has a soul from conception.",
		"Why do some Christians oppose abortion because of marriage?": "The purpose of marriage is to have children.",
		"What is a non-religious argument for abortion?": "Women should have the right to decide about their own body.",
		"What is another non-religious argument for abortion?": "Illegal abortions can be dangerous.",
		"When might abortion save lives?": "When carrying the child could result in the mother's death.",
		"What is a non-religious argument against abortion?": "Adoption is available.",
		"Why might some women oppose abortion after having one?": "They may regret their decision.",
		"What social concern is sometimes raised about abortion?": "It could lead to promiscuity."
	},

	"Euthanasia": {
		"What is euthanasia?": "The painless killing of someone dying from a painful disease.",
		"Is euthanasia legal in the UK?": "No.",
		"What is voluntary euthanasia?": "Ending life painlessly when the patient asks for it.",
		"What is non-voluntary euthanasia?": "Ending someone's life when they cannot ask but are believed to want it.",
		"What is assisted suicide?": "Providing a seriously ill person with the means to kill themselves.",
		"What is a non-religious argument for euthanasia?": "People have the right to choose when they die.",
		"How might euthanasia allow someone to die?": "With dignity.",
		"What comparison do some people make between suicide and euthanasia?": "Suicide is legal, so euthanasia should be too.",
		"Why do some people reject the 'playing God' argument?": "Modern medicine already prolongs life.",
		"What is a non-religious argument against euthanasia?": "The patient could change their mind.",
		"Why do many doctors oppose euthanasia?": "Doctors should save life, not end it.",
		"What medical argument is used against euthanasia?": "A cure could be found.",
		"What concern is raised about family influence?": "People may feel pressured by relatives.",
		"What is a Christian argument for euthanasia?": "God would not want His creation to suffer.",
		"What belief about God is used to support euthanasia?": "God is all-forgiving.",
		"What is the main Christian argument against euthanasia?": "Only God should decide when life ends.",
		"Who has said euthanasia is a sin?": "The Pope.",
		"How is life described by some Christians?": "A test.",
		"Which commandment is used against euthanasia?": "Thou shalt not kill."
	},

	"Origins & Value of the Universe": {
		"What does the Big Bang Theory teach?": "A huge explosion of matter happened 13.7 billion years ago.",
		"What does the Big Bang Theory say about matter?": "Matter is eternal.",
		"When was the solar system formed?": "5 billion years ago.",
		"What evidence supports the Big Bang Theory?": "Redshift effect, background radiation and ripples in deep space.",
		"What is Creationism?": "The belief that Genesis is literally true and science is wrong.",
		"How do Creationists explain evidence for the Big Bang?": "Noah's Flood explains it.",
		"What is the Apparent Age Theory?": "The universe was created looking older than it is.",
		"What is Intelligent Design?": "The complexity of the universe suggests a designer.",
		"What example did Paley use to support design?": "A watch.",
		"What examples are used as evidence of design?": "DNA and the human eye.",
		"Who do Intelligent Design supporters believe the designer is?": "God.",
		"What does the compatibility view teach?": "Science explains how and religion explains why.",
		"Why do some people think the Big Bang supports belief in God?": "It could not have happened by chance.",
		"Why do some believers think God is necessary for life?": "God created the laws of gravity and chemicals needed for life.",
		"Why do most Christians believe the universe has value?": "God created it and it is a gift.",
		"Who owns the Earth according to many Christians?": "God.",
		"What is stewardship?": "Looking after the world on God's behalf.",
		"What does the Old Testament teach about the land?": "It should be treated kindly.",
		"What does the Parable of the Talents teach about the environment?": "Leave more for the next generation than we received.",
		"Why do Christians believe they will care for the environment?": "They will be judged on how they looked after it.",
		"What does Genesis 1 say according to some Christians?": "Humans should rule over everything.",
		"What does evolution teach about life?": "Life evolved from single-celled organisms.",
		"What is survival of the fittest?": "The strongest survived and evolved.",
		"When did humans develop according to science?": "2.5 million years ago.",
		"What do Christian Creationists believe about species?": "God created them in six days.",
		"What does the Design Argument teach about ecosystems?": "God designed them.",
		"Why does evolution create challenges for some Christians?": "It appears to contradict the Bible.",
		"Why is Adam and Eve important to some Christians?": "Without them there is no Original Sin."
	},

	"Sanctity of Life": {
		"What is sanctity of life?": "The belief that life is sacred, holy and belongs to God.",
		"Why is human life special according to Christians?": "Humans are made in God's image and have a soul.",
		"What does sanctity of life teach about violence?": "Human life should not be treated violently.",
		"Who can give and take life according to sanctity of life?": "Only God.",
		"Why do many Christians oppose abortion and euthanasia?": "Life belongs to God.",
		"What is quality of life?": "The idea that life should have benefits to be worth living.",
		"What does the Bible say about humanity?": "God created mankind in His own image.",
		"Why do some Christians support ending suffering?": "They believe there is a duty to remove suffering.",
		"What is meant by the lesser of two evils?": "Choosing the least harmful option.",
		"What principle guides Situation Ethics?": "Do the most loving thing.",
		"Why does having a soul make humans special?": "It gives human life unique value.",
		"What does sanctity of life teach about human worth?": "Every human life is sacred.",
		"Why do some Christians prioritise quality of life?": "Life should have benefits and dignity.",
		"How does being made in God's image affect Christian beliefs?": "It makes human life sacred and valuable."
	}
}
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
	btn.disabled = true
	var team = await find_card(btn.get_parent().name)
	if team is Array or team != -1: teams[team[0]] += score if team[1] else score * -1
	for t in range(len($Center/VBox/teams.get_children())): $Center/VBox/teams.get_child(t).text = "TEAM %s: %d" % [t + 1, teams[t]]

func find_card(type):
	if type.to_pascal_case() == "Horizons":
		var id = approvedIDs.keys().pick_random() if approvedIDs.size() > 0 else ""
		while approvedIDs.is_empty() or (id != "" and id in usedIDs):
			$Awaiting.show()
			if approvedIDs.size() > 0: id = approvedIDs.keys().pick_random()
			if usedIDs.size() >= approvedIDs.size(): usedIDs.clear()
			await get_tree().create_timer(0.2).timeout
		while id == "":
			$Awaiting.show()
			if approvedIDs.size() > 0: id = approvedIDs.keys().pick_random()
			if usedIDs.size() >= approvedIDs.size(): usedIDs.clear()
			await get_tree().create_timer(0.2).timeout
		if not id in usedIDs: usedIDs.append(id)
		$Awaiting.hide()
		OS.shell_open("https://horizons.hackclub.com/projects/" + id)
		return -1
	elif not type in questions: print("NO RELATED Qs") ; return -1
	var q = questions[type].keys().pick_random()
	var qCard = preload("res://Scenes/question_card.tscn").instantiate()
	add_child(qCard, true)
	qCard.enter(q, type)
	return await qCard.team

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
	projectID = str(randi_range(0, 5000))
	url = "https://horizons.hackclub.com/api/projects/%s" % projectID
	check_url()
