defmodule ProductsTest do
  use ExUnit.Case
  doctest Products

  test "greets the world" do
    assert Products.hello() == :world
  end
end
