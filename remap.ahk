#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; CapsToEsc
Capslock::Esc

; Win + Enter
#Enter::
Run, wt.exe
return
