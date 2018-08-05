Mister Bin
==================================================

[![Gem Version](https://badge.fury.io/rb/mister_bin.svg)](https://badge.fury.io/rb/mister_bin)
[![Build Status](https://travis-ci.com/DannyBen/mister_bin.svg?branch=master)](https://travis-ci.com/DannyBen/mister_bin)
[![Maintainability](https://api.codeclimate.com/v1/badges/ae82443a99c2839d8ba8/maintainability)](https://codeclimate.com/github/DannyBen/mister_bin/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ae82443a99c2839d8ba8/test_coverage)](https://codeclimate.com/github/DannyBen/mister_bin/test_coverage)

---

A command line framework for adding command line utilities to your gems.

---

Contents
--------------------------------------------------

* [Contents](#contents)
* [Installation](#installation)
* [Design Goals](#design-goals)
* [Example](#example)
* [Usage](#usage)
* [Creating the Main Executable](#creating-the-main-executable)
    * [Runner Options](#runner-options)
* [Creating Commands](#creating-commands)
    * [Command DSL](#command-dsl)


Installation
--------------------------------------------------

    $ gem install mister_bin



Design Goals
--------------------------------------------------

- Provide an easy and minimalistic DSL for building command line utilities.
- Drastically reduce the need for boilerplate code and unnecessary wrappers 
  involved in building command line utilities.
- Provide a mechanism for separating each command and subcommand to its 
  own file.
- Allow gem developers to easily add command line interface to their gems.
- Allow for easy and straight forward testing of the generated CLI.



Example
--------------------------------------------------

See the [example](/example) folder.



Usage
--------------------------------------------------

Creating a command line utility with Mister Bin involves at least two files:

1. The main "bin" file. This is the actual executable, and if you are 
   developing a gem, this will be in the `bin` directory of your folder.
2. One or more subcommand files. These files use the DSL, and will usually be
   placed in your `lib/<your gem>/commands folder.



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


### Runner Routes

The `Runner` object needs to be told how to route commands that are executed
in the command line.

Use the `#route` method as follows:

```ruby
runner = MisterBin::Runner.new
runner.route <regex>, to: <Class Name>
```

for example:

```ruby
runner = MisterBin::Runner.new
runner.route 'dir', to: DirCommand
runner.route 'greet', to: GreetCommand
runner.route 'config init', to: ConfigInitializerCommand
runner.route 'config show', to: ConfigDisplayerCommand
```


Creating Commands
--------------------------------------------------

When the main executable is executed, it will look for files matching a 
specific pattern in the same directory and in the `PATH`.

Assuming the main executable is called `myapp`, it will look for 
`myapp-*.rb` files (e.g. `myapp-status.rb`)

These files do not need to be executables, and should use the DSL to define
their actions.



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
# The first two will create the same result as the last one.
usage "app ls"
usage "app ls --all"
usage "app ls [--all]"
usage "app new NAME"

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

# Define the actual action to execute when the command is called
# All arguments will be provided to your block.
action do |args|
  puts args['--all'] ? "success --all" : "success"
end
```


[1]: http://docopt.org/
