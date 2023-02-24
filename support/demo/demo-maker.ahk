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
  Type("rm cast.json {;} asciinema rec cast.json")

  Type("radio")
  Type("radio --help")
  Type("radio playlist")
  Type("radio p")
  Type("radio playlist --help")
  Type("madman")
  Type("madman --help")
  Type("madman preview")
  Type("madman serve -h")
  Type("kojo")
  Type("kojo file -h")

  Type("exit")
  Type("agg --font-size 20 cast.json cast.gif")
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
