; --------------------------------------------------
; This script generates the demo gif
; NOTE: This should be executed in the root folder
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

Return

Type(Command, Delay=2000) {
  Send % Command
  Sleep 500
  Send {Enter}
  Sleep Delay
}

F12::
  Type("{#} Press F11 to abort at any time")
  Type("cd ./support/demo")
  Type("rm cast.json {;} asciinema rec terminal.json")

  Type("cd mister_bin/examples/06-terminal")
  Type("./app.rb")
  Type("--help")
  Type("greet")
  Type("greet bob")
  Type("/ls -la")
  Type("exit")
  Type("exit")

  Type("agg --font-size 20 terminal.json terminal.gif")
  Sleep 400
  Type("cd ../../")
  Type("{#} Done")
Return

^F12::
  Reload
return

F11::
  ExitApp
return
