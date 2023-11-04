defmodule LittleAlchemist.Chapter07Test do
  use ExUnit.Case
  import LittleAlchemist.Chapter07

  test "set?" do
    refute set?([:apple, :peaches, :apple, :plum])
    assert set?([:apple, :peaches, :pears, :plums])
    refute set?([:apple, 3, :pear, 4, 9, :apple, 3, 4])
    assert set?([:apple, 3, :pear, 4, 9])
  end

  test "makeset" do
    assert makeset([
             :apple,
             :peach,
             :pear,
             :peach,
             :plum,
             :apple,
             :lemon,
             :peach
           ]) == [:apple, :peach, :pear, :plum, :lemon]
  end

  test "subset" do
    assert subset?([5, :chicken, :wings], [
             5,
             :hamburgers,
             2,
             :pieces,
             :fried,
             :chicken,
             :and,
             :light,
             :duckling,
             :wings
           ])

    refute subset?([4, :pounds, :of, :horseradish], [
             :four,
             :pounds,
             :chicken,
             :and,
             5,
             :ounces,
             :horseradish
           ])
  end

  test "eqset?" do
    assert eqset?([6, :large, :chickens, :with, :wings], [6, :chickens, :with, :large, :wings])

    refute eqset?([6, :large, :chickens, :with, :wings, :of], [
             6,
             :chickens,
             :with,
             :large,
             :wings
           ])
  end

  test "intersect?" do
    assert intersect?([:stewed, :tomatoes, :and, :macaroni], [:macaroni, :and, :cheese])
  end

  test "intersect" do
    assert intersect([:stewed, :tomatoes, :and, :macaroni], [:macaroni, :and, :cheese]) == [
             :and,
             :macaroni
           ]
  end

  test "union" do
    assert union([:stewed, :tomatoes, :and, :macaroni, :casserole], [:macaroni, :and, :cheese]) ==
             [:stewed, :tomatoes, :casserole, :macaroni, :and, :cheese]
  end

  test "intersectall" do
    assert intersectall([[:a, :b, :c], [:c, :a, :d, :e], [:e, :f, :g, :h, :a, :b]]) == [:a]

    assert intersectall([
             [6, :pears, :and],
             [3, :peaches, :and, :peppers],
             [8, :pears, :and, 6, :plums],
             [:and, 6, :prunes, :with, :some, :apples]
           ])
  end

  test "pair?" do
    assert pair?([3, 7])
    assert pair?([[2], [:pair]])
    assert pair?([:full, [:house]])
  end

  test "fun?" do
    refute fun?([[4, 3], [4, 2], [7, 6], [6, 2], [3, 4]])
    assert fun?([[8, 3], [4, 2], [7, 6], [6, 2], [3, 4]])
    refute fun?([[:d, 4], [:b, 0], [:b, 9], [:e, 5], [:g, 4]])
  end

  test "revrel" do
    assert revrel([[8, :a], [:pumpkin, :pie], [:got, :sick]]) == [
             [:a, 8],
             [:pie, :pumpkin],
             [:sick, :got]
           ]
  end

  test "fullfun?" do
    assert fullfun?([[8, 3], [4, 8], [7, 6], [6, 2], [3, 4]])
    refute fullfun?([[8, 3], [4, 2], [7, 6], [6, 2], [3, 4]])

    refute fullfun?([
             [:grape, :raisin],
             [:plum, :prune],
             [:stewed, :prune]
           ])
  end
end
