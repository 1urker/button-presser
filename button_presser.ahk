#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.\
#SingleInstance,Force ;make sure only one can run at a time
#InstallKeybdHook ;allow reading keyboard
#InstallMouseHook ;allow reading mouse

;TODO
;none

IniRead, target, buttons.ini, Main, target ;reads target button from file
IniRead, trigger, buttons.ini, Main, trigger ;reads trigger button from file
if (trigger = "ERROR" OR target = "ERROR")
{
	;IniWrite, "Click", buttons.ini, Main, target
	;IniWrite, "XButton2", buttons.ini, Main, trigger
	writeButtons("Click", "XButton2")
	target := "Click"
	trigger := "XButton2"
}

Hotkey, *%trigger%, autopress

+F6::ExitApp ;kill code

LShift & RShift:: ;rebinds target key
while (A_PriorKey = "LShift" or A_PriorKey = "RShift") ;loops until hotkeys aren't the last key pressed
{
	
}
target := A_PriorKey ;sets target as last key pressed
writeButtons(target, trigger) ;saves new target to file
MsgBox Target is now %A_PriorKey%
return

LControl & RControl:: ;rebinds trigger key
Hotkey, %trigger%, autopress, Off ;disables existing trigger
while (A_PriorKey = "LControl" or A_PriorKey = "RControl") ;loops until hotkeys aren't the last keys pressed
{
	
}
trigger := A_PriorKey ;sets trigger as last key pressed
Hotkey, %trigger%, autopress, On ;rebinds trigger key
writeButtons(target, trigger) ;saves new trigger to file
MsgBox Trigger is now %A_PriorKey%
return

autopress: ;does the autopressing
	While (GetKeyState(trigger,"P")) ;while trigger button is held down
	{
		SendInput {Blind}{%target%} ;send target trigger
		Sleep, 20
	}
return

writeButtons(tar, trig) ;writes to buttons file
{
	IniWrite, %tar%, buttons.ini, Main, target
	IniWrite, %trig%, buttons.ini, Main, trigger
}