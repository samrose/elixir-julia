# File: lib/julia_runner.ex
defmodule JuliaRunner do
  @julia_script "square.jl"

  def square(number) when is_number(number) do
    Task.async(fn -> do_square(number) end)
    |> Task.await(10_000)  # 10 second timeout
  end

  defp do_square(number) do
    case System.cmd("julia", [@julia_script, "#{number}"]) do
      {output, 0} ->
        {result, _} = Float.parse(String.trim(output))
        {:ok, result}
      {error, status} ->
        {:error, "Julia exited with status #{status}: #{error}"}
    end
  end

  def square_many(numbers) when is_list(numbers) do
    numbers
    |> Enum.map(&Task.async(fn -> do_square(&1) end))
    |> Enum.map(&Task.await(&1, 10_000))
  end
end
