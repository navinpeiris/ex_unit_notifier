defmodule ExUnitNotifier.MessageFormatter do
  @moduledoc false

  alias ExUnitNotifier.Counter

  def format(counter, run_us, load_us) do
    message = "#{counter.tests} tests, #{counter.failures} failures"
    if counter.skipped > 0 do
      message = "#{message}, #{counter.skipped} skipped"
    end
    "#{message} in #{format_time(run_us, load_us)} seconds"
  end

  defp format_time(run_us, load_us), do: format_us(normalize_us(run_us) + normalize_us(load_us))

  defp normalize_us(nil), do: 0
  defp normalize_us(us), do: div(us, 10_000)

  defp format_us(us) when us < 10, do: "0.0#{us}"
  defp format_us(us) do
    us = div us, 10
    "#{div(us, 10)}.#{rem(us, 10)}"
  end
end
