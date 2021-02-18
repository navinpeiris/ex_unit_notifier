defmodule ExUnitNotifier.Notifiers.TerminalNotifier do
  @moduledoc false

  def notify(status, message, _opts) do
    System.cmd(executable(), [
      "-group",
      "ex-unit-notifier",
      "-title",
      "ExUnit",
      "-message",
      message,
      "-appIcon",
      get_icon(status),
      "-contentImage",
      content_image(status)
    ])
  end

  def available?, do: executable() != nil

  defp executable, do: System.find_executable("terminal-notifier")

  defp get_icon(status),
    do: Application.app_dir(:ex_unit_notifier, "priv/icons/#{status}.icns")

  defp content_image(status),
    do: Application.app_dir(:ex_unit_notifier, "priv/icons/#{status}.png")
end
