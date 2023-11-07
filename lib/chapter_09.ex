defmodule LittleAlchemist.Chapter09 do
  import LittleAlchemist.Chapter01, only: [eq?: 2, car: 1, cdr: 1, cons: 2, null?: 1]
  import LittleAlchemist.Chapter04, only: [pick: 2]

  def looking(a, lat), do: keep_looking(a, pick(1, lat), lat)

  def keep_looking(a, sorn, lat) when is_number(sorn), do: keep_looking(a, pick(sorn, lat), lat)
  def keep_looking(a, sorn, _), do: eq?(sorn, a)

  def eternity(x), do: eternity(x)

  def first(l), do: car(l)
  def second(l), do: car(cdr(l))
  def build(s1, s2), do: cons(s1, cons(s2, []))

  def shift(pair) do
    build(first(first(pair)), build(second(first(pair)), second(pair)))
  end

  def length0(l) do
    cond do
      null?(l) -> 0
      true -> eternity(cdr(l)) + 1
    end
  end

  def length_le2_f do
    (fn length ->
       fn l ->
         cond do
           null?(l) -> 0
           true -> length.(cdr(l)) + 1
         end
       end
     end).(
      (fn length ->
         fn l ->
           cond do
             null?(l) -> 0
             true -> length.(cdr(l)) + 1
           end
         end
       end).(
        (fn length ->
           fn l ->
             cond do
               null?(l) -> 0
               true -> length.(cdr(l)) + 1
             end
           end
         end).(&eternity/1)
      )
    )
  end

  # def length_f do
  #   (fn mk_length ->
  #      mk_length.(mk_length)
  #    end).(fn mk_length ->
  #     fn l ->
  #       cond do
  #         null?(l) -> 0
  #         true -> add1(mk_length.(mk_length).(cdr(l)))
  #       end
  #     end
  #   end)
  # end

  def length_f do
    (fn mk_length ->
       mk_length.(mk_length)
     end).(fn mk_length ->
      (fn length ->
         fn l ->
           cond do
             null?(l) -> 0
             true -> length.(cdr(l)) + 1
           end
         end
       end).(fn x -> mk_length.(mk_length).(x) end)
    end)
  end

  def y(le) do
    (fn f -> f.(f) end).(fn f ->
      le.(fn x -> f.(f).(x) end)
    end)
  end
end
