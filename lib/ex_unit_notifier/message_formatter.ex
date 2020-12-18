defmodule ExUnitNotifier.MessageFormatter do
  @moduledoc false

  def format(counter, run_us, load_us) do
    "#{status_message(counter)} in #{format_time(run_us, load_us)} seconds"
  end

  defp status_message(%{tests: tests, failures: failures, excluded: excluded, skipped: skipped}) do
    message = "#{tests} tests, #{failures} failures"

    message = if excluded > 0, do: "#{message}, #{excluded} excluded", else: message
    message = if skipped > 0, do: "#{message}, #{skipped} skipped", else: message

    message
  end

  defp format_time(run_us, load_us), do: format_us(normalize_us(run_us) + normalize_us(load_us))

  defp normalize_us(nil), do: 0
  defp normalize_us(us), do: div(us, 10_000)

  defp format_us(us) when us < 10, do: "0.0#{us}"

  defp format_us(us) do
    us = div(us, 10)
    "#{div(us, 10)}.#{rem(us, 10)}"
  end
end
