# ExUnit Notifier

[![Build Status](https://github.com/navinpeiris/ex_unit_notifier/workflows/CI/badge.svg)](https://github.com/navinpeiris/ex_unit_notifier/actions?query=workflow%3ACI)
[![Hex version](https://img.shields.io/hexpm/v/ex_unit_notifier.svg "Hex version")](https://hex.pm/packages/ex_unit_notifier)
[![Hex downloads](https://img.shields.io/hexpm/dt/ex_unit_notifier.svg "Hex downloads")](https://hex.pm/packages/ex_unit_notifier)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

![screenshot](http://i.imgur.com/xywj5C1.png)

Show desktop notifications for ExUnit runs. Works very well with automatic test runners such as [mix-test.watch](https://github.com/lpil/mix-test.watch). (Yes, TDD is awesome!)

Currently notifications on OS X and Linux are supported.

## Installation

First, add `ExUnitNotifier` to your `mix.exs` dependencies:

```elixir
def deps do
  [{:ex_unit_notifier, "~> 0.1", only: :test}]
end
```

Then, update your dependencies:

```sh-session
$ mix deps.get
```

### For OS X

Ensure [terminal-notifier](https://github.com/julienXX/terminal-notifier) is installed and available through the users `PATH`.

### For Linux

Install `notify-send`:

```bash
sudo apt install libnotify-bin
```

## Usage

Add `ExUnitNotifier` to your `ExUnit` configuration in `test/test_helper.exs` file.

```elixir
ExUnit.configure formatters: [ExUnit.CLIFormatter, ExUnitNotifier]
ExUnit.start
```

Now run `mix test` and you'll see notifications popping up :)

## Notification Types

Notifications will be sent from the first available notifier that is deemed available in the order specified below:

- terminal-notifier
- notify-send
- Terminal Title if non of the above match

To force a specific type of notifier to be used, specify the notifier using the following configuration:

```elixir
config :ex_unit_notifier, notifier: ExUnitNotifier.Notifiers.TerminalNotifier
```

You can use one of the available notifiers found in [lib/ex_unit_notifier/notifiers](lib/ex_unit_notifier/notifiers), or you can write your own.

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
