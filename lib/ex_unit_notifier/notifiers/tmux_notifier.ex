defmodule ExUnitNotifier.Notifiers.TmuxNotifier do
  @moduledoc false

  def notify(status, _message, _opts) do
    pane = System.get_env("TMUX_PANE")

    if pane do
      # tmux set-window-option -t"$TMUX_PANE" window-status-style bg=red
      System.cmd("tmux", ["set-window-option", "-t#{pane}", "window-status-style", style(status)])
    end
  end

  def available?, do: true

  defp style(status) do
    if status == :error do
      "bg=red"
    else
      "bg=green"
    end
  end
end
