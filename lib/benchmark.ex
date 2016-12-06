defmodule Benchmark do
  @doc """
  Quick and dirty benchmarking of a function, in seconds.
  Source: http://stackoverflow.com/a/29674651/560215
  """
  def measure(function) do
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end
