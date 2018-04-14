Mister Bin
==================================================

[![Gem Version](https://badge.fury.io/rb/mister_bin.svg)](https://badge.fury.io/rb/mister_bin)
[![Build Status](https://travis-ci.org/DannyBen/mister_bin.svg?branch=master)](https://travis-ci.org/DannyBen/mister_bin)
[![Maintainability](https://api.codeclimate.com/v1/badges/ae82443a99c2839d8ba8/maintainability)](https://codeclimate.com/github/DannyBen/mister_bin/maintainability)

---

Build modular command line utilities.

---

Installation
--------------------------------------------------

    $ gem install mister_bin



Design Goals
--------------------------------------------------

- Provide an easy and minimalistic DSL for building command line utilities.
- Provide a mechanism for separating each subcommand to its separate file.
- Support the ability to extend a given command from different sources.



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

exit MisterBin::Runner.run __FILE__, ARGV
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

Alternatively, if you prefer to handle all `repo` subcommands in a single, 
file, simple implement these instead:

1. `git`
2. `git-status.rb`
3. `git-repo.rb`



Creating the Main Executable
--------------------------------------------------

The main executable is usually simple, and contains this code:

```ruby
# git
#!/usr/bin/env ruby
require 'mister_bin'

exit MisterBin::Runner.run __FILE__, ARGV
```

This code will start the execution chain based on the arguments provided 
when running it.

The `Runner.run` method requires two parameters:

1. The path to the base executable file (usually, `__FILE__` is what you 
   need).
2. An array of arguments (usually `ARGV` is what you need).



Creating Subcommands
--------------------------------------------------

When the main executable is executed, it will look for files matching a 
specific pattern in the same directory.

Assuming the main executable is called `myapp`, it will look for 
`myapp-*.rb` files (e.g. `myapp-status.rb`)

These files do not need to be executables, and should use the DSL to define
their actions.



The DSL
--------------------------------------------------

The DSL is designed to create a [docopt][1] document. Most commands are 
optional.

The below example outlines all available DSL commands.


```ruby
# Optional help string
help "A short sentence or paragraph describing the command"

# Version string for the command
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

# Provide examples
example "app ls"
example "app ls --all"

# Define the actual action to execute when the command is called
# All arguments will be provided to your block.
action do |args|
  puts args['--all'] ? "success --all" : "success"
end


[1]: http://docopt.org/