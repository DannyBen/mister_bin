Mister Bin
==================================================

[![Gem Version](https://badge.fury.io/rb/mister_bin.svg)](https://badge.fury.io/rb/mister_bin)
[![Build Status](https://travis-ci.com/DannyBen/mister_bin.svg?branch=master)](https://travis-ci.com/DannyBen/mister_bin)
[![Maintainability](https://api.codeclimate.com/v1/badges/ae82443a99c2839d8ba8/maintainability)](https://codeclimate.com/github/DannyBen/mister_bin/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ae82443a99c2839d8ba8/test_coverage)](https://codeclimate.com/github/DannyBen/mister_bin/test_coverage)

---

Mister Bin lets you develop rich, scalable and testable command line 
interfaces for your gem or other Ruby application.

---

Contents
--------------------------------------------------

* [Installation](#installation)
* [Design Goals](#design-goals)
* [Examples](#examples)
* [Usage](#usage)
* [Creating the Main Executable](#creating-the-main-executable)
   * [Runner Options](#runner-options)
   * [Runner Routes](#runner-routes)
* [Creating Commands](#creating-commands)
   * [Command DSL](#command-dsl)
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

This screencast shows several command line applications that use Mister Bin.

![Demo](https://raw.githubusercontent.com/DannyBen/mister_bin/master/demo/demo.gif)



Examples
--------------------------------------------------

See the [examples](/examples) folder for several example use cases.



Usage
--------------------------------------------------

Creating a command line utility with Mister Bin involves at least two files:

1. The main "bin" file. This is the actual executable, and if you are 
   developing a gem, this will be in the `bin` directory of your folder.
2. One or more subcommand files. These files use the DSL, and will usually be
   placed in your `lib/<your gem>/commands` folder.

WHen executing the commands, you can use only the first letters of the 
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

The DSL is designed to create a [docopt][1] document. Most commands are 
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


In the Wild
--------------------------------------------------

Several examples of real world use of Mister Bin in the wild (well, 
"In the Back Yard" really...).

- [AudioAddict][4] - Command line utility for the AudioAddict radio network
- [Madman][3] - The Markdown Swiss Army Knife
- [Kojo][2] - Command line utility for generating config files from templates 
  and definition files


[1]: http://docopt.org/
[2]: https://github.com/DannyBen/kojo
[3]: https://github.com/DannyBen/madman
[4]: https://github.com/DannyBen/audio_addict
