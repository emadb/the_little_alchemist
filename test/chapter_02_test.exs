defmodule LittleAlchemist.Chapter02Test do
  use ExUnit.Case
  import LittleAlchemist.Chapter02

  test "lat?" do
    res = lat?([:jack, :sprat, :could, :eat, :no, :chicken])
    assert res == true

    res = lat?([[:jack], :sprat, :could, :eat, :no, :chicken])
    assert res == false
  end

  test "member?" do
    res = member?(:c, [:a, :b, :c, :d])
    assert res == true

    res = member?(:f, [:a, :b, :c, :d])
    assert res == false
  end
end
