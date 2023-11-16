defmodule ExUnitNotifier do
  @moduledoc """
  Shows notifications for ExUnit test runs

  To enable notifications, add `ExUnitNotifier` as a formatter in your `test_helper.exs`:

      ExUnit.configure formatters: [ExUnit.CLIFormatter, ExUnitNotifier]
  """

  use GenServer

  alias ExUnitNotifier.Counter
  alias ExUnitNotifier.MessageFormatter

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
    Ding.send(
      "ExUnit",
      MessageFormatter.format(counter, run_us, load_us),
      message_opts(counter)
    )

    {:noreply, counter}
  end

  # Elixir version >= 1.12.0, see https://hexdocs.pm/ex_unit/1.12.0/ExUnit.Formatter.html
  def handle_cast({:suite_finished, %{run: run_us, async: _async_us, load: load_us}}, counter) do
    Ding.send(
      "ExUnit",
      MessageFormatter.format(counter, run_us, load_us),
      message_opts(counter)
    )

    {:noreply, counter}
  end

  def handle_cast(_, counter), do: {:noreply, counter}

  defp status(
    %Counter{failures: failures, invalid: invalid}
  ) when failures > 0 or invalid > 0, do: :error
  defp status(_), do: :ok

  defp color(:error), do: "red"
  defp color(_status), do: "green"

  defp message_opts counter do %{
    clear_history: Application.get_env(:ex_unit_notifier, :clear_history, false),
    color: color(status(counter)),
    icon_png: icon_png(status(counter)),
    icon_icns: icon_icns(status(counter)),
  } end

  defp icon_png(status), do: Application.app_dir(:ex_unit_notifier, "priv/icons/#{status}.png")
  defp icon_icns(status), do: Application.app_dir(:ex_unit_notifier, "priv/icons/#{status}.icns")
end
