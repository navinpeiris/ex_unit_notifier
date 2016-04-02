defmodule ExUnitNotifier.Icon do
  @moduledoc false

  def get_icon(:ok), do: "Success" |> get_icon_path
  def get_icon(_), do: "Failed" |> get_icon_path

  defp get_icon_path(icon_name), do: Application.app_dir(:ex_unit_notifier, "priv/icons/#{icon_name}.icns")
end
