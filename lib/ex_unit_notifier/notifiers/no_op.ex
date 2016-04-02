defmodule ExUnitNotifier.Notifiers.NoOp do
  @moduledoc false

  def notify(_status, _message), do: true
  def available?, do: true
end
