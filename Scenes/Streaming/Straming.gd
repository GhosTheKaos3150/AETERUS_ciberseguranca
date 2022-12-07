extends Control

var text = "O que é Live Streaming?"
var label = 1
var started = false
var ending = false

func _ready():
	$Label1.text = ""


func _input(event):
	if event.is_action_pressed("ui_accept") and not started:
		$write_timer.start()
		started = true


func _on_write_timer_timeout():
	if not text.empty():
		if not ending:
			get_node("Label{n}".format({"n": label})).text += text[0]
			text.erase(0, 1)
		else:
			$Ending/Label5.text += text[0]
			text.erase(0, 1)
	else:
		$Timer.start()
		$write_timer.stop()


func _on_Timer_timeout():
	match label:
		1: 
			$Animation.play("Primeira")
			text = "Uma das meios de entretenimento ao vivo mais conhecidos na "+\
			"atualidade são as Live Streamings, transmissões ao vivo que podem "+\
			"ter diversos tipos de conteúdo e público alvo diversificado."
			label = 2
		2:
			text = "Por ser muito conhecido e permitir interação direta entre "+\
			"público e produtor, existem lacunas de segurança que permitem que "+\
			"agentes maliciosos possam usar esse meio para obter dados dos "+\
			"usuários, seja ele o \"streamer\" ou um telespectador."
			label = 3
			$write_timer.start()
			
		3:
			yield(get_tree().create_timer(1.5), "timeout")
			ending = true
			label = 4
			text = "AETERUS"
			
			$Stramings.hide()
			$Label1.hide()
			$Label2.hide()
			$Label3.hide()
			$Ending.show()
			$write_timer.wait_time = 0.2
			$write_timer.start()


func _on_Animation_animation_finished(anim_name):
	match anim_name:
		"Primeira": 
			$Animation.play("Segunda")
			$Audio.play()
			$write_timer.start()
