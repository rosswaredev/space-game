extends Node


enum Screen {
	STORE,
	BATTLE
}


signal screen_changed(screen: Screen, scene)
