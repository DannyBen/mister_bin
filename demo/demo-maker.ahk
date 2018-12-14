; --------------------------------------------------
; This script generates the demo gif
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

Commands := []
Index := 1

Commands.Push("ttystudio demo.gif")
Commands.Push("radio")
Commands.Push("radio --help")
Commands.Push("radio playlist")
Commands.Push("radio p")
Commands.Push("radio playlist --help")
Commands.Push("madman")
Commands.Push("madman --help")
Commands.Push("madman preview")
Commands.Push("madman serve -h")
Commands.Push("kojo")
Commands.Push("kojo file -h")
Commands.Push("exit")

F12::
  Send % Commands[Index]
  Index := Index + 1
return

^F12::
  Reload
return

^x::
  ExitApp
return
