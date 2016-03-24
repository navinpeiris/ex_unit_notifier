defmodule ExUnitNotifier.Counter do
  defstruct [tests: 0, failures: 0, skipped: 0, invalid: 0]

  def add_test(counter), do: %{counter | tests: counter.tests + 1}
  def add_failed(counter), do: %{counter | failures: counter.failures + 1}
  def add_skipped(counter), do: %{counter | skipped: counter.skipped + 1}
  def add_invalid(counter), do: %{counter | invalid: counter.invalid + 1}
end
