# Queen

[![Gem Version](https://badge.fury.io/rb/queen.svg)][gem]
[![Build Status](https://secure.travis-ci.org/piotrmurach/queen.svg?branch=master)][travis]
[![Build status](https://ci.appveyor.com/api/projects/status/atibfgu43dit3xkt?svg=true)][appveyor]
[![Maintainability](https://api.codeclimate.com/v1/badges/23e0a5aab6623aebd854/maintainability)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/queen/badge.svg?branch=master)][coverage]
[![Inline docs](http://inch-ci.org/github/piotrmurach/queen.svg?branch=master)][inchpages]

[gem]: http://badge.fury.io/rb/queen
[travis]: http://travis-ci.org/piotrmurach/queen
[appveyor]: https://ci.appveyor.com/project/piotrmurach/queen
[codeclimate]: https://codeclimate.com/github/piotrmurach/queen/maintainability
[coverage]: https://coveralls.io/github/piotrmurach/queen?branch=master
[inchpages]: http://inch-ci.org/github/piotrmurach/queen

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

```ruby
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

freddie.rb:3:25: prostitute may be viewed as offensive. Consider removing this word.

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

## Configuration


All **Queen** rules are enabled by default and can be configured in `.queen.yml` file. Default configuration:

```ruby
---
rules:
  profanity:
    enabled: true
    exclude: []
  word_spelling:
    enabled: true
    exclude: []
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotrmurach/queen. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Copyright

Copyright (c) 2017-2018 Piotr Murach. See LICENSE for further details.
