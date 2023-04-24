defmodule ExUnitNotifier do
  @moduledoc """
  Shows notifications for ExUnit test runs

  To enable notifications, add `ExUnitNotifier` as a formatter in your `test_helper.exs`:

      ExUnit.configure formatters: [ExUnit.CLIFormatter, ExUnitNotifier]

  """

  use GenServer

  alias ExUnitNotifier.Counter
  alias ExUnitNotifier.MessageFormatter

  @notifiers [
    ExUnitNotifier.Notifiers.TerminalNotifier,
    ExUnitNotifier.Notifiers.NotifySend,
    ExUnitNotifier.Notifiers.TmuxNotifier,
    ExUnitNotifier.Notifiers.TerminalTitle
  ]

  def init(_opts), do: {:ok, %Counter{}}

  def handle_cast({:test_finished, %ExUnit.Test{state: nil}}, counter),
    do: {:noreply, counter |> Counter.add_test()}

  def handle_cast({:test_finished, %ExUnit.Test{state: {:failed, _}}}, counter),
    do: {:noreply, counter |> Counter.add_test() |> Counter.add_failed()}

  def handle_cast({:test_finished, %ExUnit.Test{state: {:excluded, _}}}, counter),
    do: {:noreply, counter |> Counter.add_test() |> Counter.add_excluded()}

  def handle_cast({:test_finished, %ExUnit.Test{state: {:skipped, _}}}, counter),
    do: {:noreply, counter |> Counter.add_test() |> Counter.add_skipped()}

  def handle_cast({:test_finished, %ExUnit.Test{state: {:invalid, _}}}, counter),
    do: {:noreply, counter |> Counter.add_test() |> Counter.add_invalid()}

  # Elixir version < 1.12.0
  def handle_cast({:suite_finished, run_us, load_us}, counter) do
    apply(notifier(), :notify, [
      status(counter),
      MessageFormatter.format(counter, run_us, load_us),
      opts()
    ])

    {:noreply, counter}
  end

  # Elixir version >= 1.12.0, see https://hexdocs.pm/ex_unit/1.12.0/ExUnit.Formatter.html
  def handle_cast({:suite_finished, %{run: run_us, async: _async_us, load: load_us}}, counter) do
    apply(notifier(), :notify, [
      status(counter),
      MessageFormatter.format(counter, run_us, load_us),
      opts()
    ])

    {:noreply, counter}
  end

  def handle_cast(_, counter), do: {:noreply, counter}

  defp status(%Counter{failures: failures, invalid: invalid}) when failures > 0 or invalid > 0,
    do: :error

  defp status(_), do: :ok

  defp opts,
    do: %{
      clear_history: Application.get_env(:ex_unit_notifier, :clear_history, false)
    }

  defp notifier, do: Application.get_env(:ex_unit_notifier, :notifier, first_available_notifier())

  defp first_available_notifier,
    do: @notifiers |> Enum.find(fn notifier -> notifier.available? end)
end
