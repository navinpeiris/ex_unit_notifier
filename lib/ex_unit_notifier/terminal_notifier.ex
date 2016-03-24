defmodule ExUnitNotifier.TerminalNotifier do
  alias ExUnitNotifier.Counter

  def notify(%Counter{} = counter, run_us, load_us) do
    executable = System.find_executable "terminal-notifier"
    if executable do
      System.cmd executable, ["-group", "ex-unit-notifier",
                              "-title", "ExUnit",
                              "-message", get_message(counter, run_us, load_us),
                              "-appIcon", get_icon(counter)]
    end
  end

  defp get_message(counter, run_us, load_us) do
    message = "#{counter.tests} tests, #{counter.failures} failures"
    if counter.skipped > 0 do
      message = "#{message}, #{counter.skipped} skipped"
    end
    "#{message} in #{format_time(run_us, load_us)} seconds"
  end

  defp format_time(run_us, load_us), do: format_us(normalize_us(run_us) + normalize_us(load_us))

  defp normalize_us(us), do: div(us, 10000)

  defp format_us(us) do
    if us < 10 do
      "0.0#{us}"
    else
      us = div us, 10
      "#{div(us, 10)}.#{rem(us, 10)}"
    end
  end

  defp get_icon(%Counter{failures: failures, invalid: invalid}) when failures > 0 or invalid > 0, do: "Failed" |> get_icon_path
  defp get_icon(_), do: "Success" |> get_icon_path

  defp get_icon_path(icon_name), do: Application.app_dir(:ex_unit_notifier, "priv/icons/#{icon_name}.icns")
end
