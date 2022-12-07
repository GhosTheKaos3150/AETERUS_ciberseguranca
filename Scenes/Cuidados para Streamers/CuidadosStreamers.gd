extends Control

var text = "Cuidados para Streamers"
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
			text = "É importante que o Streamer tome alguns cuidados "+\
			"essenciais antes, durante e após a transmissão."
			label = 2
		2:
			text = "Entre eles podemos destacar:\n1. Ativar Autenticaçaõ de Dois "+\
			"Fatores\n2. Criar senhas fortes\n3 Não transmitir conteúdo privado\n"+\
			"4. Moderar o Chat da transmissão\n5. Certificar que a Live finalizou "+\
			"corretamente."
			label = 3
			$write_timer.start()
			
		3:
			yield(get_tree().create_timer(1.5), "timeout")
			ending = true
			label = 4
			text = "AETERUS"
			
			$Streamer.hide()
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
