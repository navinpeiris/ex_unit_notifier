defmodule ExUnitNotifier do
  use GenEvent

  alias ExUnitNotifier.Counter
  alias ExUnitNotifier.TerminalNotifier

  def init(_opts), do: {:ok, %Counter{}}

  def handle_event({:suite_finished, run_us, load_us}, counter) do
    TerminalNotifier.notify counter, run_us, load_us
    :remove_handler
  end

  def handle_event({:test_finished, %ExUnit.Test{state: nil}}, counter), do: {:ok, counter |> Counter.add_test}
  def handle_event({:test_finished, %ExUnit.Test{state: {:failed, _}}}, counter), do: {:ok, counter |> Counter.add_test |> Counter.add_failed}
  def handle_event({:test_finished, %ExUnit.Test{state: {:skip, _}}}, counter), do: {:ok, counter |> Counter.add_test |> Counter.add_skipped}
  def handle_event({:test_finished, %ExUnit.Test{state: {:invalid, _}}}, counter), do: {:ok, counter |> Counter.add_test |> Counter.add_invalid}

  def handle_event(_, counter), do: {:ok, counter}
end
