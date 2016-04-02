defmodule ExUnitNotifier do
  use GenEvent

  alias ExUnitNotifier.Counter
  alias ExUnitNotifier.MessageFormatter

  @notifiers [
    ExUnitNotifier.Notifiers.TerminalNotifier,
    ExUnitNotifier.Notifiers.NoOp
  ]

  def init(_opts), do: {:ok, %Counter{}}

  def handle_event({:test_finished, %ExUnit.Test{state: nil}}, counter), do: {:ok, counter |> Counter.add_test}
  def handle_event({:test_finished, %ExUnit.Test{state: {:failed, _}}}, counter), do: {:ok, counter |> Counter.add_test |> Counter.add_failed}
  def handle_event({:test_finished, %ExUnit.Test{state: {:skip, _}}}, counter), do: {:ok, counter |> Counter.add_test |> Counter.add_skipped}
  def handle_event({:test_finished, %ExUnit.Test{state: {:invalid, _}}}, counter), do: {:ok, counter |> Counter.add_test |> Counter.add_invalid}

  def handle_event({:suite_finished, run_us, load_us}, counter) do
    notifier.notify status(counter), MessageFormatter.format(counter, run_us, load_us)
    :remove_handler
  end

  def handle_event(_, counter), do: {:ok, counter}

  defp status(%Counter{failures: failures, invalid: invalid}) when failures > 0 or invalid > 0, do: :error
  defp status(_), do: :ok

  defp notifier, do: Application.get_env(:ex_unit_notifier, :notifier, first_available_notifier)

  defp first_available_notifier, do: @notifiers |> Enum.find(fn notifier -> notifier.available? end)
end
