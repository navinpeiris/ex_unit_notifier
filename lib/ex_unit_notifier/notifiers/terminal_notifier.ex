defmodule ExUnitNotifier.Notifiers.TerminalNotifier do
  @moduledoc false

  alias ExUnitNotifier.Icon

  def notify(status, message) do
    System.cmd executable, ["-group", "ex-unit-notifier",
                            "-title", "ExUnit",
                            "-message", message,
                            "-appIcon", Icon.get_icon(status)]
  end

  def available?, do: executable != nil

  defp executable, do: System.find_executable "terminal-notifier"
end
