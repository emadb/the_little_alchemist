defmodule LittleAlchemist.Chapter01Test do
  use ExUnit.Case
  import LittleAlchemist.Chapter01

  test "car" do
    assert car([:a, :b, :c]) == :a
    assert car([[:a, :b, :c], :x, :y])  == [:a, :b, :c]
  end

  test "cdr" do
    assert cdr([:a, :b, :c]) == [:b, :c]
    assert cdr([[:a, :b, :c], :x, :y]) == [:x, :y]
  end

  test "car + cdr" do
    assert car(cdr([[:b], [:x, :y], [[:c]]])) == [:x, :y]
    assert cdr(cdr([[:b], [:x, :y], [[:c]]])) == [[[:c]]]
  end

  test "cons" do
    assert cons(:peanut, [:butter, :and, :jelly]) == [:peanut, :butter, :and, :jelly]
    assert cons([:banana, :and], [:peanut, :butter, :and, :jelly]) == [[:banana, :and], :peanut, :butter, :and, :jelly]
    assert cons([:a, [:b, [:c]]], []) == [[:a, [:b, [:c]]]]
  end

  test "null?" do
    assert null?([:a, :b, :c]) == false
    assert null?([]) == true
  end

  test "atom?" do
    assert atom?(:a) == true
    assert atom?([:a, :b, :c]) == false
  end

  test "atom + car + cdr" do
    assert atom?(car([:a, :b, :c])) == true
    assert atom?(cdr([:a, :b, :c])) == false
  end

  test "eq?" do
    assert eq?(:a, :a) == true
    assert eq?(:a, :b) == false
  end

end
