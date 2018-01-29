defmodule BandwidthApiTest do
  use ExUnit.Case
  doctest BandwidthApi

  test "greets the world" do
    assert BandwidthApi.hello() == :world
  end
end
