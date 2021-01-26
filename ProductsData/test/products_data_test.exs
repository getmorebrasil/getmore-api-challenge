defmodule ProductsDataTest do
  use ExUnit.Case
  doctest ProductsData

  test "greets the world" do
    assert ProductsData.hello() == :world
  end
end
