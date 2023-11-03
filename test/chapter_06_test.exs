defmodule LittleAlchemist.Chapter06Test do
  use ExUnit.Case
  import LittleAlchemist.Chapter06

  test "numbered?" do
    assert numbered?(2)
    refute numbered?(:a)
    assert numbered?([3, :+, [4, :*, 5]])
    refute numbered?([3, :*, :sausage])
  end

  test "value" do
    assert value(13) == 13
    assert value([1, :+, 3]) == 4
    assert value([1, :+, [3, :^, 4]]) == 82
  end

  test "zero?" do
    assert sero?([])
  end

  test "edd1" do
    assert edd1([]) == [[]]
    assert edd1([[]]) == [[], []]
  end

  test "zub1" do
    assert zub1([[], []]) == [[]]
    assert zub1([[]]) == []
  end

  test "edd" do
    assert edd([[], []], [[], [], []]) == [[], [], [], [], []]
  end
end
