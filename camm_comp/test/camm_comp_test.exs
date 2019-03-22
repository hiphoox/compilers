defmodule CammCompTest do
  use ExUnit.Case
  doctest CammComp

  test "greets the world" do
    assert CammComp.hello() == :world
  end
end
