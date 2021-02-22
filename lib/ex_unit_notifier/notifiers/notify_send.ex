defmodule ExUnitNotifier.Notifiers.NotifySend do
  @moduledoc false

  def notify(status, message, opts) do
    System.cmd(executable(), build_args(status, message, opts))
  end

  def available?, do: executable() != nil

  defp executable, do: System.find_executable("notify-send")

  defp build_args(status, message, %{clear_history: clear_history}) do
    args = [
      "--app-name=ExUnit",
      "--icon=#{get_icon(status)}",
      "ExUnit",
      message
    ]

    maybe_add_clear_history(args, clear_history)
  end

  defp maybe_add_clear_history(args, true),
    do: List.insert_at(args, 2, "--hint=int:transient:1")

  defp maybe_add_clear_history(args, _clear_history), do: args

  defp get_icon(status),
    do: Application.app_dir(:ex_unit_notifier, "priv/icons/#{status |> Atom.to_string()}.png")
end
