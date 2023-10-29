defmodule LittleAlchemist.Chapter01 do
  def car([h | _]), do: h

  def cdr([_ | t]), do: t

  def cons(a, l), do: [a | l]

  def null?([]), do: true
  def null?(_), do: false

  def atom?([_ | _]), do: false
  def atom?(_), do: true

  def eq?(a, b), do: a == b
end
