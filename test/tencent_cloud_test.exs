defmodule TencentCloudTest do
  use ExUnit.Case
  doctest TencentCloud

  test "greets the world" do
    assert TencentCloud.hello() == :world
  end
end
