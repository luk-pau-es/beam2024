defmodule EtsAccessTest do
  use ExUnit.Case
  doctest EtsAccess

  test "greets the world" do
    assert EtsAccess.hello() == :world
  end
end
