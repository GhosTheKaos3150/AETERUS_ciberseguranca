extends Control

var text = "Você sabe o que é\nSegurança da Informação?"
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
			text = "Na Internet e no mundo real, estamos\nsujeitos a ataques de "+\
			"agentes maliciosos\nque desejam roubar nossos dados."
			label = 2
		
		2:
			text = "Por isso, é importante sabermos como proteger nossa privacidade "+\
			"e lidar com ataques cibernéticos!"
			label = 3
			$write_timer.start()
		3:
			$Animation.play("Terceira")


func _on_Animation_animation_finished(anim_name):
	match anim_name:
		"Primeira":
			$Audio.play()
			$write_timer.start()
			$Animation.play("Segunda")
		"Terceira":
			yield(get_tree().create_timer(1.5), "timeout")
			ending = true
			label = 4
			
			$Label1.hide()
			$Label2.hide()
			$Label3.hide()
			$Label4.hide()
			$Woman.hide()
			$Ending.show()
			text = "AETERUS"
			$write_timer.wait_time = 0.2
			$write_timer.start()
