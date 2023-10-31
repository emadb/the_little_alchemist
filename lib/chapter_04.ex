defmodule LittleAlchemist.Chapter04 do

  def zero?(n), do: n == 0

  def add1(n), do: n + 1
  def sub1(n), do: n - 1

  # def add(n, m) do
  #   cond do
  #     zero?(m) -> n
  #     true -> add1(sub1(m) + n)
  #   end
  # end

  def add(n, 0), do: n
  def add(n, m), do: 1 + add(n, m - 1)


  def sub(n, 0), do: n
  def sub(n, m), do: sub(n, m - 1) - 1


  def addtup([]), do: 0
  def addtup([h | t]), do: add(h, addtup(t))

  def addtup(t1, []), do: t1
  def addtup([], t2), do: t2
  def addtup([h1|t1], [h2|t2]), do: [h1 + h2 | addtup(t1, t2)]

  # def addtup([], l), do: l
  # def addtup(l, []), do: l
  # def addtup(a, b), do: cons(add(car(a), car(b)), addtup(cdr(a), cdr(b)))

  def mul(n, 1), do: n
  def mul(n, m), do: n + mul(n, m-1)


  def greater_than(0, _), do: false
  def greater_than(_, 0), do: true
  def greater_than(x, y), do: greater_than(sub1(x), sub1(y))

  def less_than(_, 0), do: false
  def less_than(0, _), do: true
  def less_than(x, y), do: less_than(sub1(x), sub1(y))


  # def equals(n, m) do
  #   cond do
  #     greater_than(n, m) -> false
  #     less_than(n, m) -> false
  #     true -> true
  #   end
  # end

  def equals(0, 0), do: true
  def equals(_, 0), do: false
  def equals(0, _), do: false
  def equals(n, m), do: equals(n-1, m-1)

  def power(_, 0), do: 1
  def power(n, m), do: mul(n, power(n, sub1(m)))

  # def power(n, 1), do: n
  # def power(n, m), do: n * power(n, m-1)

  # def divide(n, m) do
  #   cond do
  #     less_than(n, m) -> 0
  #     true -> add1(divide(sub(n, m), m))
  #   end
  # end

  def divide(n, m) when n < m, do: 0
  def divide(n, m), do: 1 + divide(n-m, m)

  def size([]), do: 0
  def size([_ | t]), do: 1 + size(t)

  # def pick(n, lat) do
  #   cond do
  #     equals(sub1(n), 0) -> car(lat)
  #     true -> pick(sub1(n), cdr(lat))
  #   end
  # end

  def pick(1, [h | _]), do: h
  def pick(n, [_ | t]), do: pick(n - 1, t)

  def rempick(1, [_ | t]), do: t
  def rempick(n, [h | t]), do: [h | rempick(n-1, t)]


  def nonums([]), do: []
  def nonums([h | t]) when is_number(h), do: nonums(t)
  def nonums([h | t]), do: [h | nonums(t)]

  def allnums([]), do: []
  def allnums([h | t]) when not is_number(h), do: allnums(t)
  def allnums([h | t]), do: [h | allnums(t)]

  def equan(a, a), do: true
  def equan(_, _), do: false

  def occur(_, []), do: 0
  def occur(a, [a | t]), do: 1 + occur(a, t)
  def occur(a, [_ | t]), do: occur(a, t)

  def one?(1), do: true
  def one?(_), do: false

end
