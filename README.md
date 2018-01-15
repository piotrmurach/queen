# Queen

> **Queen** is an English langauge linter that reports on spelling, grammar, and other crimes against the written word, and will help you hold your code and comments in high esteem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'queen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install queen

## Usage

Running the `queen` command with no arguments will check all source files in the current directory:

```
$ queen
```

Alternatively, you can `specify` a list of files and/or directories to be scanned, like so:

```
$ queen lib spec file.rb
```

For example, let's assume the following sentence by Freddie Mercury:

```
class Freddie
  def say
    "I'm just a musical prostitute, my dear."
  end
end
```

After **Queen** reviews the file (named `freddie.rb`), the following reprimands are given:

```
Reviewing 1 file

Reprimands:

freddie.rb:1:20: Profanity: prostitute may be viewed as offensive.

1 file checked, 1 reprimand given.
```

To see all available commands add `-h` or `--help` flag:

```
$ queen -h (--help)
```

| Command flag  | Description |
|---------------|-------------|
| --[no-]color  | Force color output on or off. |
| -d/--debug    | Change log level to DEBUG. |
| -o/--out      | Write output to a file instead of stdout. |
| -r/--require  | Require Ruby file. |
| --verbose     | Change log level to VERBOSE. |
| -v/--version  | Display the current version and exit. |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotrmurach/queen. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Copyright

Copyright (c) 2017 Piotr Murach. See LICENSE for further details.
