defmodule LittleAlchemist.Chapter03 do
  import LittleAlchemist.Chapter01

  # def rember(a, lat) do
  #   cond do
  #     null?(lat) -> []
  #     eq?(car(lat), a) -> cdr(lat)
  #     true -> cons(car(lat), rember(a, cdr(lat)))
  #   end
  # end

  def rember(_a, []), do: []
  def rember(a, [a | t]), do: t
  def rember(a, [h | t]), do: cons(h, rember(a, t))

  # def firsts(l) do
  #   cond do
  #     null?(l) -> []
  #     true -> cons(car(car(l)), firsts(cdr(l)))
  #   end
  # end

  def firsts([]), do: []
  def firsts([[h | _] | t]), do: [h | firsts(t)]


  # def insertR(new, old, lat) do
  #   cond do
  #     null?(lat) -> []
  #     eq?(old, car(lat)) -> cons(old, cons(new, cdr(lat)))
  #     true -> cons(car(lat), insertR(new, old, cdr(lat)))
  #   end
  # end

  def insertR(_, _, []), do: []
  def insertR(new, h, [h | t]), do: [h, new | t]
  def insertR(new, old, [h | t]), do: [h | insertR(new, old, t)]

  # def insertL(new, old, lat) do
  #   cond do
  #     null?(lat) -> []
  #     eq?(old, car(lat)) -> cons(new, cons(old, cdr(lat)))
  #     true -> cons(car(lat), insertL(new, old, cdr(lat)))
  #   end
  # end

  def insertL(_, _, []), do: []
  def insertL(new, h, [h | t]), do: [new, h | t]
  def insertL(new, old, [h | t]), do: [h | insertL(new, old, t)]

  # def subst(new, old, lat) do
  #   cond do
  #     null?(lat) -> []
  #     eq?(old, car(lat)) -> cons(new, cdr(lat))
  #     true -> cons(car(lat), subst(new, old, cdr(lat)))
  #   end
  # end

  def subst(_, _, []), do: []
  def subst(new, h, [h | t]), do: [new | t]
  def subst(new, old, [h | t]), do: [h | subst(new, old, t)]

  # def subst2(new, o1, o2, lat) do
  #   cond do
  #     null?(lat) -> []
  #     eq?(o1, car(lat)) -> cons(new, cdr(lat))
  #     eq?(o2, car(lat)) -> cons(new, cdr(lat))
  #     true -> cons(car(lat), subst2(new, o1, o2, cdr(lat)))
  #   end
  # end

  def subst2(_, _, _, []), do: []
  def subst2(new, o1, _, [o1 | t]), do: [new | t]
  def subst2(new, _, o2, [o2 | t]), do: [new | t]
  def subst2(new, o1, o2, [h | t]), do: [h | subst2(new, o1, o2, t)]

  # def multirember(a, lat) do
  #   cond do
  #     null?(lat) -> []
  #     eq?(car(lat), a) -> multirember(a, cdr(lat))
  #     true -> cons(car(lat), multirember(a, cdr(lat)))
  #   end
  # end

  def multirember(_a, []), do: []
  def multirember(a, [a | t]), do: multirember(a, t)
  def multirember(a, [h | t]), do: cons(h, multirember(a, t))

  # def multiinsertR(new, old, lat) do
  #   cond do
  #     null?(lat) -> []
  #     eq?(old, car(lat)) -> cons(old, cons(new, multiinsertR(new, old, cdr(lat))))
  #     true -> cons(car(lat), multiinsertR(new, old, cdr(lat)))
  #   end
  # end

  def multiinsertR(_, _, []), do: []
  def multiinsertR(new, h, [h | t]), do: [h, new | multiinsertR(new, h, t)]
  def multiinsertR(new, old, [h | t]), do: [h | multiinsertR(new, old, t)]

  # def multiinsertL(new, old, lat) do
  #   cond do
  #     null?(lat) -> []
  #     eq?(old, car(lat)) -> cons(new, cons(old, multiinsertL(new, old, cdr(lat))))
  #     true -> cons(car(lat), multiinsertL(new, old, cdr(lat)))
  #   end
  # end

  def multiinsertL(_, _, []), do: []
  def multiinsertL(new, h, [h | t]), do: [new, h | multiinsertL(new, h, t)]
  def multiinsertL(new, old, [h | t]), do: [h | multiinsertL(new, old, t)]

  # def multisubst(new, old, lat) do
  #   cond do
  #     null?(lat) -> []
  #     eq?(old, car(lat)) -> cons(new, multisubst(new, old, cdr(lat)))
  #     true -> cons(car(lat), multisubst(new, old, cdr(lat)))
  #   end
  # end

  def multisubst(_, _, []), do: []
  def multisubst(new, h, [h | t]), do: [new | multisubst(new, h, t)]
  def multisubst(new, old, [h | t]), do: [h | multisubst(new, old, t)]
end
