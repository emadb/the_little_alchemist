defmodule LittleAlchemist.Chapter02 do
  # def lat?(lat) do
  #   cond do
  #     null?(lat) -> true
  #     atom?(car(lat)) -> lat?(cdr(lat))
  #     true -> false
  #   end
  # end

  def lat?([]), do: true
  def lat?([[_ | _] | _]), do: false
  def lat?([_ | t]), do: lat?(t)

  # def member?(a, lat) do
  #   cond do
  #     null?(lat) -> false
  #     true -> eq?((car (lat)), a) || member?(a, cdr(lat))
  #   end
  # end

  def member?(_, []), do: false
  def member?(h, [h | _]), do: true
  def member?(a, [_ | t]), do: member?(a, t)
end
