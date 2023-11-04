defmodule LittleAlchemist.Chapter08Test do
  use ExUnit.Case
  import LittleAlchemist.Chapter08
  import LittleAlchemist.Chapter01, only: [eq?: 2, null?: 1]
  import LittleAlchemist.Chapter04, only: [greater_than: 2, less_than: 2]
  import LittleAlchemist.Chapter05, only: [eqlist?: 2]

  def equalnum?(a, b), do: !greater_than(a, b) && !less_than(a, b) && true
  def eqan?(a, b) when is_atom(a) and is_atom(b), do: eq?(a, b)
  def eqan?(a, b) when is_number(a) and is_number(b), do: equalnum?(a, b)
  def eqan?(_, _), do: false

  def equal?(a, b) when is_atom(a) and is_atom(b), do: eqan?(a, b)
  def equal?(a, _) when is_atom(a), do: false
  def equal?(_, b) when is_atom(b), do: false
  def equal?(l1, l2), do: eqlist?(l1, l2)

  test "rember_f" do
    assert rember_f(&eq?/2).(5, [6, 2, 5, 3]) == [6, 2, 3]
    assert rember_f(&eq?/2).(:jelly, [:jelly, :beans, :are, :good]) == [:beans, :are, :good]

    assert rember_f(&equal?/2).([:pop, :corn], [
             :lemonade,
             [:pop, :corn],
             :and,
             [:cake]
           ]) == [:lemonade, :and, [:cake]]
  end

  test "insertL_f" do
    assert insertL_f(&eq?/2).(
             :topping,
             :fudge,
             [:ice, :cream, :with, :fudge, :for, :dessert]
           ) == [:ice, :cream, :with, :topping, :fudge, :for, :dessert]

    assert insertL_f(&eq?/2).(
             :topping,
             :fudge,
             [:ice, :cream, :with, :for, :dessert]
           ) == [:ice, :cream, :with, :for, :dessert]

    assert insertL_f(&equal?/2).(
             :fudge,
             [:topping, :fudge],
             [:ice, :cream, :with, [:topping, :fudge], :for, :dessert]
           ) == [:ice, :cream, :with, :fudge, [:topping, :fudge], :for, :dessert]
  end

  test "insertR_f" do
    assert insertR_f(&eq?/2).(
             :topping,
             :fudge,
             [:ice, :cream, :with, :fudge, :for, :dessert]
           ) == [:ice, :cream, :with, :fudge, :topping, :for, :dessert]

    assert insertR_f(&eq?/2).(
             :topping,
             :fudge,
             [:ice, :cream, :with, :for, :dessert]
           ) == [:ice, :cream, :with, :for, :dessert]

    assert insertR_f(&equal?/2).(
             :fudge,
             [:topping, :fudge],
             [:ice, :cream, :with, [:topping, :fudge], :for, :dessert]
           ) == [:ice, :cream, :with, [:topping, :fudge], :fudge, :for, :dessert]
  end

  test "multirember_f" do
    assert multirember_f(&eq?/2).(
             :cup,
             [:coffee, :cup, :tea, :cup, :and, :hick, :cup]
           ) == [:coffee, :tea, :and, :hick]

    assert multirember_f(&equal?/2).(
             [:cup, :coffee],
             [
               :coffee,
               :cup,
               :coffee,
               [:cup, :coffee],
               :tea,
               :cup,
               :and,
               [:cup, :coffee],
               :hick,
               :cup
             ]
           ) == [:coffee, :cup, :coffee, :tea, :cup, :and, :hick, :cup]
  end

  test "multiremberT" do
    assert multiremberT(&eq?(&1, :tuna), [:shrimp, :salad, :tuna, :salad, :and, :tuna]) == [
             :shrimp,
             :salad,
             :salad,
             :and
           ]
  end

  test "multirember_and_co" do
    a_friend = fn _newlat, seen -> null?(seen) end

    assert multirember_and_co(:tuna, [], a_friend)
    refute multirember_and_co(:tuna, [:tuna], a_friend)
    refute multirember_and_co(:tuna, [:and, :tuna], a_friend)

    assert multirember_and_co(:tuna, [:strawberries, :tuna, :and, :swordfish], fn newlat, _seen ->
             length(newlat)
           end) == 3
  end

  test "multiinsertLR" do
    assert multiinsertLR(
             :new,
             :cup,
             :coffee,
             [:coffee, :cup, :tea, :cup, :coffee, :and, :hick, :cup]
           ) == [
             :coffee,
             :new,
             :new,
             :cup,
             :tea,
             :new,
             :cup,
             :coffee,
             :new,
             :and,
             :hick,
             :new,
             :cup
           ]
  end

  test "multiinsertLR_and_co" do
    assert multiinsertLR_and_co(
             :new,
             :cup,
             :coffee,
             [:coffee, :cup, :tea, :cup, :coffee, :and, :hick, :cup],
             fn newlat, cl, cr -> [newlat, cl, cr] end
           ) == [
             [
               :coffee,
               :new,
               :new,
               :cup,
               :tea,
               :new,
               :cup,
               :coffee,
               :new,
               :and,
               :hick,
               :new,
               :cup
             ],
             3,
             2
           ]

    assert multiinsertLR_and_co(
             :salty,
             :fish,
             :chips,
             [
               :chips,
               :and,
               :fish,
               :or,
               :fish,
               :and,
               :chips
             ],
             fn newlat, cl, cr -> [newlat, cl, cr] end
           ) == [
             [:chips, :salty, :and, :salty, :fish, :or, :salty, :fish, :and, :chips, :salty],
             2,
             2
           ]
  end

  test "evens_only_star" do
    assert evens_only_star([
             [9, 1, 2, 8],
             3,
             10,
             [[9, 9], 7, 6],
             2
           ]) == [[2, 8], 10, [[], 6], 2]
  end

  test "evens_only_star_and_co" do
    assert evens_only_star_and_co(
             [
               [9, 1, 2, 8],
               3,
               10,
               [[9, 9], 7, 6],
               2
             ],
             fn newl, p, s -> [newl, p, s] end
           ) == [[[2, 8], 10, [[], 6], 2], 1920, 38]
  end
end
