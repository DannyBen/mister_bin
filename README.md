Mister Bin
==================================================

[![Gem Version](https://badge.fury.io/rb/mister_bin.svg)](https://badge.fury.io/rb/mister_bin)
[![Build Status](https://github.com/DannyBen/mister_bin/workflows/Test/badge.svg)](https://github.com/DannyBen/mister_bin/actions?query=workflow%3ATest)
[![Maintainability](https://api.codeclimate.com/v1/badges/ae82443a99c2839d8ba8/maintainability)](https://codeclimate.com/github/DannyBen/mister_bin/maintainability)

---

Mister Bin lets you develop rich, scalable and testable command line 
interfaces for your gem or other Ruby application.

---

Contents
--------------------------------------------------

* [Installation](#installation)
* [Feature Highlights](#feature-highlights)
* [Examples](#examples)
* [Usage](#usage)
* [Creating the Main Executable](#creating-the-main-executable)
   * [Runner Options](#runner-options)
   * [Runner Routes](#runner-routes)
* [Creating Commands](#creating-commands)
   * [Command DSL](#command-dsl)
* [Interactive Terminal](#interactive-terminal)
   * [Terminal features](#terminal-features)
   * [Terminal options](#terminal-options)
* [In the Wild](#in-the-wild)



Installation
--------------------------------------------------

    $ gem install mister_bin



Feature Highlights
--------------------------------------------------

- Easy to use and minimalistic DSL for describing your command line actions.
- Each command is defined with a separate class for maximum testability and 
  scalability.
- Commands can have subcommands.
- Designed for gem developers.



Examples
--------------------------------------------------

![Demo](https://raw.githubusercontent.com/DannyBen/mister_bin/master/demo/demo.gif)

- See the [examples](/examples) folder for several example use cases.
- For real world examples, see the [In the Wild](#in-the-wild) section.



Usage
--------------------------------------------------

Creating a command line utility with Mister Bin involves at least two files:

1. The main "bin" file. This is the actual executable, and if you are 
   developing a gem, this will be in the `bin` directory of your folder.
2. One or more subcommand files. These files use the DSL, and will usually be
   placed in your `lib/<your gem>/commands` folder.

When executing the commands, you can use only the first letters of the 
command name. Mister Bin will search for the command that starts with your 
input, and if it finds one and one only, it will execute it. For example, 
if you have a `server` command, you can execute it with `yourapp s` if it
is the only command that starts with an `s`.



Creating the Main Executable
--------------------------------------------------

The main executable is usually simple and only serves to initialize Mister 
Bin with options.

This is the minimal code:

```ruby
#!/usr/bin/env ruby
runner = MisterBin::Runner.new

runner.route 'dir',   to: DirCommand
runner.route 'greet', to: GreetCommand

exit runner.run ARGV
```

### Runner Options

The `Runner` object accepts an optional hash of options:

```ruby
runner = MisterBin::Runner.new version: '1.2.3',
  header: 'My command line app'
  footer: 'Use --help for additional info',
```

#### `version`

Version number to display when running the main executable with `--version`.

#### `header`

Text to display before the list of commands.

#### `footer`

Text to display after the list of commands.

#### `commands`

A hash of `{ 'command_name' => ClassName }` to serve as command routes.
This is equivalent to adding routes later with 
`runner.route 'command_name', to: ClassName`.


#### `handler`

Provide a single handler to all commands. When this is provided, `commands`
are ignored.
This is equivalent to using `runner.route_all to: ClassName`.


### Runner Routes

The `Runner` object needs to be told how to route commands that are executed
in the command line.

Use the `#route` method as follows:

```ruby
runner = MisterBin::Runner.new
runner.route <command_name>, to: <Class Name>
```

for example:

```ruby
runner = MisterBin::Runner.new
runner.route 'dir', to: DirCommand
runner.route 'greet', to: GreetCommand
runner.route 'config', to: ConfigCommand
```

If you wish to route all commands to the same class, you can use:

```ruby
runner = MisterBin::Runner.new
runner.route_all to: <Class Name>
```

for example:

```ruby
runner = MisterBin::Runner.new
runner.route_all to: GlobalCommand
```



Creating Commands
--------------------------------------------------

Create command classes by inheriting from `MisterBin::Command`, for example:

```ruby
require 'mister_bin'

class GreetCommand < MisterBin::Command
  summary "Say hi"
  usage "app greet [NAME]"
  param "NAME", "The recipient of the greeting"

  def run
    # args hash is available everywhere in the calss
    name = args['NAME'] || 'Luke'
    puts "#{name}... I am your father..."
  end
end
```

These classes can use any of the below DSL commands, and must define a
`def run(args)` method.


### Command DSL

The DSL is designed to create a [docopt] document. Most commands are 
optional.

The below example outlines all available DSL commands.


```ruby
# Optional summary string
summary "A short sentence or paragraph describing the command"

# Optional help string
help "A longer explanation can go here"

# Optional version string for the command
version "0.1.1"

# Usage patterns. You can use either a compact docopt notation, or provide
# multiple usage calls.
usage "app ls"
usage "app ls [--all]"
usage "app new NAME"

# Describe any subcommands
# Note that this has an additional important use:
# - For each command defined with the `command` directive, we will search 
#   for a method with the same name and a `_command` suffix.
# - If no such method is found, we will call the generic `run` method.
command "ls", "Show list of files"
command "new", "Pretend to create a new application"

# Describe any flags
option "--all", "Also show hidden files"
option "-f --force", "Force delete"

# Describe any parameters
param "NAME", "The name of the repository"

# Describe any environment variables that your app cares about
environment "SECRET", "There is no spoon"

# Provide examples
example "app ls"
example "app ls --all"
```



Interactive Terminal
--------------------------------------------------
Mister Bin comes with an interactive terminal that allows you to set up a
console that sends all commands to your runner.

![Demo](https://raw.githubusercontent.com/DannyBen/mister_bin/master/demo/terminal.gif)

See the [terminal example](/examples/06-terminal) folder.

In order to start a terminal, you need to provide it with a 
`MisterBin::Runner` object:

```ruby
runner = MisterBin::Runner.new 
runner.route 'greet', to: GreetCommand
terminal = MisterBin::Terminal.new runner
terminal.start
```

### Terminal features

- All commands will be routed to the runner.
- Customizable autocomplete.
- Command history (up/down arrows).
- Start a command with a `/` in order to run a system (shell) command.
- Type `exit` to quit (or Ctrl+D or Ctrl+C).
- Customizable header, exit message, exit command and prompt.


### Terminal options

The `MisterBin::Terminal.new` command accepts an optional second argument. If 
provided, it should be a options hash:

```
terminal = MisterBin::Terminal.new runner, {
  header: "Welcome",
  autocomplete: %w[--help greet]
}
```

In addition, you may wish to provide your own code blocks for handling some
commands that are not handled by your runner. For example, this piece of code
will capture the `/cd ...` command from the terminal and pass it to your 
block:

```
terminal = MisterBin::Terminal.new runner
terminal.on '/cd' do |args|
  Dir.chdir args[0] if args[0]
  puts Dir.pwd
end
```

These are the available options. All string options are displayed with 
the [Colsole] `say` command so they support color markers.

#### `header`

Message to show when starting the terminal.
Default: blank.

#### `show_usage`

If true, the runner will be executed on startup to show its usage patterns.
Default: `false`.

#### `prompt`

The string for the prompt. Default: `"\n> "`.

#### `autocomplete`

An array of words to autocomplete by pressing Tab.
Default: none.

#### `exit_message`

The message to show on exit.
Default: blank.

#### `exit_commands`

An array of commands that if typed, will exit the terminal.
Default: `["exit", "q"]`.

#### `system_character`

The prefix character that if typed at the beginning of a command, will avoid
executing the runner, and instead execute a system (shell) command. 
Default: `"/"`.

#### `disable_system_shell`

If true, commands that start with `/` will *not* be delegated to the stsrem.
Default: `false`.


In the Wild
--------------------------------------------------

Several examples of real world use of Mister Bin in the wild (well, 
"In the Back Yard" really...).

- [AudioAddict] - Command line utility for the AudioAddict radio network
- [Bashly] - Bash command line framework and CLI Generator
- [Jobly] - Compact job server with API, CLI and Web UI
- [Kojo] - Command line utility for generating config files from templates and definition files
- [Madman] - The Markdown Swiss Army Knife
- [Slacktail] - Command line utility for following your Slack chat from the terminal
- [Site Link Analyzer] - Command line utility for finding broken links in a site


[docopt]: http://docopt.org/
[Kojo]: https://github.com/DannyBen/kojo
[Madman]: https://github.com/DannyBen/madman
[AudioAddict]: https://github.com/DannyBen/audio_addict
[Colsole]: https://github.com/dannyben/colsole
[Jobly]: https://github.com/dannyben/jobly
[Slacktail]: https://github.com/dannyben/slacktail
[Site Link Analyzer]: https://github.com/dannyben/sla
[Bashly]: https://github.com/DannyBen/bashly
