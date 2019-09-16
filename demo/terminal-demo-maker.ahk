; --------------------------------------------------
; This script generates the demo gif
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

Commands := []
Index := 1

Commands.Push("ttystudio terminal.gif")
Commands.Push("cd mister_bin/examples/06-terminal")
Commands.Push("./app.rb")
Commands.Push("--help")
Commands.Push("greet")
Commands.Push("greet bob")
Commands.Push("/ls -la")
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
