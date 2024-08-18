defmodule JuliaExTest do
  use ExUnit.Case
  doctest JuliaEx

  test "greets the world" do
    assert JuliaEx.hello() == :world
  end
end
