defmodule LittleAlchemist.Chapter07 do
  import LittleAlchemist.Chapter02, only: [member?: 2]
  import LittleAlchemist.Chapter03, only: [multirember: 2, firsts: 1]

  def set?([]), do: true

  def set?([h | t]) do
    cond do
      member?(h, t) -> false
      true -> set?(t)
    end
  end

  def makeset([]), do: []
  def makeset([h | t]), do: [h | makeset(multirember(h, t))]

  def subset?([], _), do: true

  def subset?([h | t], s) do
    cond do
      member?(h, s) -> subset?(t, s)
      true -> false
    end
  end

  def eqset?(a, b), do: subset?(a, b) && subset?(b, a)

  # def eqset?([], [_ | _]), do: true
  # def eqset?([h | t], s) do
  #   cond do
  #     member?(h, s) -> eqset?(t, s)
  #     true -> false
  #   end
  # end

  def intersect?([], [_ | _]), do: false

  def intersect?([h | t], s) do
    cond do
      member?(h, s) -> true
      true -> intersect?(t, s)
    end
  end

  def intersect([], _), do: []

  def intersect([h | t], s) do
    cond do
      member?(h, s) -> [h | intersect(t, s)]
      true -> intersect(t, s)
    end
  end

  def union([], s), do: s

  def union([h | t], s) do
    cond do
      member?(h, s) -> union(t, s)
      true -> [h | union(t, s)]
    end
  end

  def intersectall([]), do: []
  def intersectall([h | []]), do: h
  def intersectall([h | t]), do: intersect(h, intersectall(t))

  def pair?([_, _]), do: true
  def pair?(_), do: false

  def fun?(rel) do
    rel
    |> firsts()
    |> set?()
  end

  def revrel([]), do: []
  def revrel([[a, b] | t]), do: [[b, a] | revrel(t)]

  def seconds([]), do: []
  def seconds([[_ | t1] | t]), do: [t1 | seconds(t)]

  def fullfun?(rel) do
    rel
    |> seconds()
    |> set?()
  end
end
