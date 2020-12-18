defmodule ExUnitNotifier.Counter do
  @moduledoc false

  defstruct tests: 0, failures: 0, excluded: 0, skipped: 0, invalid: 0

  def add_test(counter), do: %{counter | tests: counter.tests + 1}
  def add_failed(counter), do: %{counter | failures: counter.failures + 1}
  def add_excluded(counter), do: %{counter | excluded: counter.excluded + 1}
  def add_skipped(counter), do: %{counter | skipped: counter.skipped + 1}
  def add_invalid(counter), do: %{counter | invalid: counter.invalid + 1}
end
