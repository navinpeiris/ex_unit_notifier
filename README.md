# ExUnit Notifier

[![Build Status](https://github.com/navinpeiris/ex_unit_notifier/workflows/CI/badge.svg)](https://github.com/navinpeiris/ex_unit_notifier/actions?query=workflow%3ACI)
[![Hex version](https://img.shields.io/hexpm/v/ex_unit_notifier.svg "Hex version")](https://hex.pm/packages/ex_unit_notifier)
[![Hex docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ex_unit_notifier/)
[![Hex downloads](https://img.shields.io/hexpm/dt/ex_unit_notifier.svg "Hex downloads")](https://hex.pm/packages/ex_unit_notifier)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)
[![Last Updated](https://img.shields.io/github/last-commit/navinpeiris/ex_unit_notifier.svg)](https://github.com/navinpeiris/ex_unit_notifier/commits/master)

![screenshot](http://i.imgur.com/xywj5C1.png)

Show desktop notifications for ExUnit runs. Works very well with automatic test runners such as [mix-test.watch](https://github.com/lpil/mix-test.watch). (Yes, TDD is awesome!)

Currently notifications on OS X and Linux are supported.

## Installation

First, add `ExUnitNotifier` to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:ex_unit_notifier, "~> 1.1", only: :test}
  ]
end
```

Then, update your dependencies:

```bash
$ mix deps.get
```

### For macOS

Follow [installation instruction](https://github.com/julienXX/terminal-notifier) of `terminal-notifier` if you need to install a particular version.

Otherwise, install current version via Homebrew:

```bash
$ brew install terminal-notifier
```

### For GNU/Linux

Install `notify-send`:

```bash
$ sudo apt install libnotify-bin
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

## Notification Options

For `notify-send` users, it is possible to clear the notifications from notifications center history using the following configuration, defaults to `false`:

```elixir
config :ex_unit_notifier, clear_history: true
```

### Copyright and License

Copyright (c) 2016 Navin Peiris

Source code is released under [the MIT license](./LICENSE.md).
