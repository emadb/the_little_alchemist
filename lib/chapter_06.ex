defmodule LittleAlchemist.Chapter06 do
  import LittleAlchemist.Chapter04, only: [power: 2]

  def numbered?([left, op, right]) when op in [:+, :*, :^],
    do: numbered?(left) && numbered?(right)

  def numbered?(n), do: is_number(n)

  def value([left, :+, right]), do: value(left) + value(right)
  def value([left, :*, right]), do: value(left) * value(right)
  def value([left, :^, right]), do: power(value(left), value(right))
  def value(n) when is_number(n), do: n

  def sero?([]), do: true
  def sero?(_), do: false

  def edd1(a), do: [[] | a]
  def zub1([_ | t]), do: t

  def edd(a, []), do: a
  def edd(a, [_ | t]), do: edd([[] | a], t)
end
