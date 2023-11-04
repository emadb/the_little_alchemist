defmodule LittleAlchemist.Chapter08 do
  import LittleAlchemist.Chapter01, only: [null?: 1, car: 1, cdr: 1, cons: 2, eq?: 2]
  import LittleAlchemist.Chapter03, only: [rember: 2]
  import LittleAlchemist.Chapter04, only: [add1: 1, mul: 2, add: 2, power: 2]

  def rember_f(fun) do
    fn a, lat ->
      cond do
        null?(lat) -> []
        fun.(car(lat), a) -> cdr(lat)
        true -> cons(car(lat), rember(a, cdr(lat)))
      end
    end
  end

  def insertL_f(fun) do
    fn old, new, lat ->
      []

      cond do
        null?(lat) -> []
        fun.(old, car(lat)) -> cons(new, cons(old, cdr(lat)))
        true -> cons(car(lat), insertL_f(fun).(new, old, cdr(lat)))
      end
    end
  end

  def insertR_f(fun) do
    fn old, new, lat ->
      []

      cond do
        null?(lat) -> []
        fun.(old, car(lat)) -> cons(old, cons(new, cdr(lat)))
        true -> cons(car(lat), insertR_f(fun).(new, old, cdr(lat)))
      end
    end
  end

  def multirember_f(fun) do
    fn a, lat ->
      cond do
        null?(lat) -> []
        fun.(car(lat), a) -> multirember_f(fun).(a, cdr(lat))
        true -> cons(car(lat), multirember_f(fun).(a, cdr(lat)))
      end
    end
  end

  def multiremberT(_fun, []), do: []

  def multiremberT(fun, [h | t]) do
    cond do
      fun.(h) -> multiremberT(fun, t)
      true -> cons(h, multiremberT(fun, t))
    end
  end

  def multirember_and_co(_, [], fun), do: fun.([], [])

  def multirember_and_co(a, [h | t], fun) do
    cond do
      eq?(a, h) ->
        multirember_and_co(a, t, fn newlat, seen ->
          fun.(newlat, cons(h, seen))
        end)

      true ->
        multirember_and_co(a, t, fn newlat, seen ->
          fun.(cons(h, newlat), seen)
        end)
    end
  end

  def multiinsertLR(_, _, _, []), do: []

  def multiinsertLR(new, oldL, oldR, [h | t]) do
    cond do
      eq?(oldL, h) -> cons(new, cons(h, multiinsertLR(new, oldL, oldR, t)))
      eq?(oldR, h) -> cons(h, cons(new, multiinsertLR(new, oldL, oldR, t)))
      true -> cons(h, multiinsertLR(new, oldL, oldR, t))
    end
  end

  def multiinsertLR_and_co(_, _, _, [], fun), do: fun.([], 0, 0)

  def multiinsertLR_and_co(new, oldL, oldR, [h | t], fun) do
    cond do
      eq?(oldL, h) ->
        multiinsertLR_and_co(new, oldL, oldR, t, fn newlat, cl, cr ->
          fun.(cons(new, cons(h, newlat)), add1(cl), cr)
        end)

      eq?(oldR, h) ->
        multiinsertLR_and_co(new, oldL, oldR, t, fn newlat, cl, cr ->
          fun.(cons(h, cons(new, newlat)), cl, add1(cr))
        end)

      true ->
        multiinsertLR_and_co(new, oldL, oldR, t, fn newlat, cl, cr ->
          fun.(cons(h, newlat), cl, cr)
        end)
    end
  end

  def insert_g(seq) do
    fn
      _, _, [] ->
        []

      new, old, [h | t] ->
        cond do
          eq?(old, h) -> seq.(new, old, t)
          true -> cons(h, insert_g(seq).(new, old, t))
        end
    end
  end

  def insertL(new, old, l) do
    insert_g(fn new, old, l -> cons(new, cons(old, l)) end).(new, old, l)
  end

  def insertR(new, old, l) do
    insert_g(fn new, old, l -> cons(old, cons(new, l)) end).(new, old, l)
  end

  def subst(new, old, l) do
    insert_g(fn new, _old, l -> cons(new, l) end).(new, old, l)
  end

  def atom_to_function(x) do
    case x do
      :+ -> &add/2
      :* -> &mul/2
      :^ -> &power/2
    end
  end

  def value(nexp) do
    cond do
      is_atom(nexp) ->
        nexp

      true ->
        atom_to_function(car(cdr(nexp))).(value(car(nexp)), value(car(cdr(cdr(nexp)))))
    end
  end

  def evens_only_star([]), do: []

  def evens_only_star([n | t]) when is_number(n) do
    cond do
      even?(n) -> cons(n, evens_only_star(t))
      true -> evens_only_star(t)
    end
  end

  def evens_only_star([h | t]), do: cons(evens_only_star(h), evens_only_star(t))

  def evens_only_star_and_co([], fun), do: fun.([], 1, 0)

  def evens_only_star_and_co([n | t], fun) when is_number(n) do
    cond do
      even?(n) ->
        evens_only_star_and_co(t, fn newl, p, s ->
          fun.(cons(n, newl), mul(p, n), s)
        end)

      true ->
        evens_only_star_and_co(t, fn newl, p, s ->
          fun.(newl, p, add(s, n))
        end)
    end
  end

  def evens_only_star_and_co([h | t], fun) do
    evens_only_star_and_co(h, fn al, ap, as ->
      evens_only_star_and_co(t, fn dl, dp, ds ->
        fun.(cons(al, dl), mul(ap, dp), add(as, ds))
      end)
    end)
  end

  def even?(n), do: n == mul(div(n, 2), 2)
end
