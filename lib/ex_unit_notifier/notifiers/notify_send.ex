defmodule ExUnitNotifier.Notifiers.NotifySend do
  @moduledoc false

  def notify(status, message) do
    System.cmd executable, ["--app-name=ExUnit",
                            "--icon=#{get_icon(status)}",
                            "ExUnit",
                            message]
  end

  def available?, do: executable != nil

  defp executable, do: System.find_executable "notify-send"

  defp get_icon(status), do: Application.app_dir(:ex_unit_notifier, "priv/icons/#{status |> Atom.to_string}.png")
end
