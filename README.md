# ExUnit Notifier

[![Build Status](https://travis-ci.org/navinpeiris/ex_unit_notifier.svg?branch=master)](https://travis-ci.org/navinpeiris/ex_unit_notifier)
[![Hex version](https://img.shields.io/hexpm/v/ex_unit_notifier.svg "Hex version")](https://hex.pm/packages/ex_unit_notifier)
[![Hex downloads](https://img.shields.io/hexpm/dt/ex_unit_notifier.svg "Hex downloads")](https://hex.pm/packages/ex_unit_notifier)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/navinpeiris/ex_unit_notifier.svg)](https://beta.hexfaktor.org/github/navinpeiris/ex_unit_notifier)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)


![screenshot](http://i.imgur.com/xywj5C1.png)

Show desktop notifications for ExUnit runs. Works incredibly well together with automatic test runners such as [mix-test.watch](https://github.com/lpil/mix-test.watch). (Yes, TDD is awesome!)

Currently only notifications through OS X Notification Center is supported, but support for Growl, Linux and Windows will be coming soon. Pull requests will be highly appreciated!


## Prerequisites

On OS X, this plugin depends on [terminal-notifier](https://github.com/julienXX/terminal-notifier) being installed and available through the current users' `PATH`

You can install terminal notifier using **either** of the following:

```sh-session
$ brew install terminal-notifier
$ gem install terminal-notifier
```

## Installation

First, add ExUnitNotifier to your `mix.exs` dependencies:

```elixir
def deps do
  [{:ex_unit_notifier, "~> 0.1", only: :test}]
end
```

Then, update your dependencies:

```sh-session
$ mix deps.get
```

## Usage

Add `ExUnitNotifier` to your `ExUnit` configuration in `test/test_helper.exs` file.

```elixir
ExUnit.configure formatters: [ExUnit.CLIFormatter, ExUnitNotifier]
ExUnit.start
```

Now run `mix test` and you'll see notifications popping up :)

### License

The MIT License

Copyright (c) 2016-present Navin Peiris

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
