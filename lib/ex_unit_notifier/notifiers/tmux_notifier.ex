defmodule ExUnitNotifier.Notifiers.TmuxNotifier do
  @moduledoc false

  def notify(status, _message, _opts) do
    if pane() do
      # tmux set-window-option -t"$TMUX_PANE" window-status-style bg=red
      System.cmd(executable(), [
        "set-window-option",
        "-t#{pane()}",
        "window-status-style",
        style(status)
      ])
    end
  end

  def available?, do: executable() != nil && pane() != nil

  defp executable, do: System.find_executable("tmux")

  defp pane, do: System.get_env("TMUX_PANE")

  defp style(status) do
    if status == :error do
      "bg=red"
    else
      "bg=green"
    end
  end
end
