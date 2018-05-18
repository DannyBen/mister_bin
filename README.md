Mister Bin
==================================================

[![Gem Version](https://badge.fury.io/rb/mister_bin.svg)](https://badge.fury.io/rb/mister_bin)
[![Build Status](https://travis-ci.org/DannyBen/mister_bin.svg?branch=master)](https://travis-ci.org/DannyBen/mister_bin)
[![Maintainability](https://api.codeclimate.com/v1/badges/ae82443a99c2839d8ba8/maintainability)](https://codeclimate.com/github/DannyBen/mister_bin/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ae82443a99c2839d8ba8/test_coverage)](https://codeclimate.com/github/DannyBen/mister_bin/test_coverage)

---

Build modular command line utilities.

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
- Support the ability to extend a given command from different sources.
- Allow gem developers to easily add command line interface to their gems.
- Allow for easy and straight forward testing of the generated CLI.



Example
--------------------------------------------------

See the [example](/example) folder.



Usage
--------------------------------------------------

Creating a command line utility with Mister Bin involves at least two files:

1. The main "app" file. This is the actual "executable".
2. One or more subcommand files. These files use the DSL.

For example, assuming we would like to create a command line tool similar 
to `git`, we will create two files:

The `git` executable:

```ruby
# git
#!/usr/bin/env ruby
require 'mister_bin'

runner = MisterBin::Runner.new 'git', basedir: __dir__
exitcode =  runner.run ARGV
```

The file to handle the `git push` command:

```ruby
# git-push.rb
version "0.1.0"
help "Push git repo"

usage "git push [--all]"

option "--all", "Push all branches"

action do |args|
  if args['--all']
    puts "pushing all"
  else
    puts "pushing, some..."
  end
end
```

Mister Bin also provides support for secondary subcommands. For example,
if you want to create a command line that responds to the below commands:

```
$ git status
$ git repo create
$ git repo delete
```

You will need to create these files:

1. `git`
2. `git-status.rb`
3. `git-repo-create.rb`
4. `git-repo-delete.rb`

Alternatively, if you prefer to handle all `repo` subcommands in a single 
file, simply implement these instead:

1. `git`
2. `git-status.rb`
3. `git-repo.rb`



Creating the Main Executable
--------------------------------------------------

The main executable is usually simple and only serves to initialize Mister 
Bin with options.

This is the minimal code:

```ruby
# git
#!/usr/bin/env ruby
require 'mister_bin'

runner = MisterBin::Runner.new 'appname'
exitcode = runner.run ARGV
exit exitcode
```

### Runner Options

The `Runner` method requires only the name of the main executable:

```ruby
runner = MisterBin::Runner.new 'appname'
```

In addition, you can provide an options hash:

```ruby
options = {
  header: 'My command line app'
  version: '1.2.3',
  footer: 'Use --help for additional info',
  basedir: __dir__, 
  isolate: true
}

runner = MisterBin::Runner.new 'appname', options
```

#### `version`

Version number to display when running the main executable with `--version`.

#### `header`

Text to display before the list of commands.

#### `footer`

Text to display after the list of commands.

#### `basedir`

The directory that holds the command files. 

By default, the runner will look for its command files in all the `PATH` 
directories. You may add another directory to this search path by specifying
it with `basedir`

#### `isolate`

If you wish to prevent runner from searching in the `PATH` directories, 
specify `isolate: true`


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
