defmodule LittleAlchemist.Chapter05 do
  import LittleAlchemist.Chapter01

  def rember_star(_, []), do: []
  def rember_star(a, [a | t]), do: rember_star(a, t)
  def rember_star(a, [h | t]) when is_atom(h), do: [h | rember_star(a, t)]
  def rember_star(a, [h | t]), do: [rember_star(a, h) | rember_star(a, t)]

  def insertR_star(_, _, []), do: []
  def insertR_star(n, o, [o | t]), do: [o, n | insertR_star(n, o, t)]
  def insertR_star(n, o, [h | t]) when is_atom(h), do: [h | insertR_star(n, o, t)]
  def insertR_star(n, o, [h | t]), do: [insertR_star(n, o, h) | insertR_star(n, o, t)]

  def occur_star(_, []), do: 0
  def occur_star(a, [a | t]), do: 1 + occur_star(a, t)
  def occur_star(a, [h | t]) when is_atom(h), do: occur_star(a, t)
  def occur_star(a, [h | t]), do: occur_star(a, h) + occur_star(a, t)

  def subst_star(_, _, []), do: []
  def subst_star(n, o, [o | t]), do: [n | subst_star(n, o, t)]
  def subst_star(n, o, [h | t]) when is_atom(h), do: [h | subst_star(n, o, t)]
  def subst_star(n, o, [h | t]), do: [subst_star(n, o, h) | subst_star(n, o, t)]

  def insertL_star(_, _, []), do: []
  def insertL_star(n, o, [o | t]), do: [n, o | insertL_star(n, o, t)]
  def insertL_star(n, o, [h | t]) when is_atom(h), do: [h | insertL_star(n, o, t)]
  def insertL_star(n, o, [h | t]), do: [insertL_star(n, o, h) | insertL_star(n, o, t)]

  def member_star(_, []), do: false
  def member_star(a, [a | _]), do: true
  def member_star(a, [h | t]) when is_atom(h), do: member_star(a, t)
  def member_star(a, [h | t]), do: member_star(a, h) || member_star(a, t)

  def leftmost([]), do: []
  def leftmost([h | _]) when is_atom(h), do: h
  def leftmost([h | _]), do: leftmost(h)

  def eqlist?([], []), do: true
  def eqlist?([], _), do: false
  def eqlist?(_, []), do: false
  def eqlist?([h1 | _], [h2 | _]) when is_atom(h1) and not is_atom(h2), do: false
  def eqlist?([h1 | _], [h2 | _]) when not is_atom(h1) and is_atom(h2), do: false

  def eqlist?([h1 | t1], [h2 | t2]) when is_atom(h1) and is_atom(h2),
    do: h1 == h2 && eqlist?(t1, t2)

  def eqlist?([h1 | t1], [h2 | t2]), do: eqlist?(h1, h2) && eqlist?(t1, t2)
end
