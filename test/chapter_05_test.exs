defmodule LittleAlchemist.Chapter05Test do
  use ExUnit.Case
  import LittleAlchemist.Chapter05

  test "rember_star" do
    assert rember_star(:cup, [
             [:coffee],
             :cup,
             [[:tea], :cup],
             [:and, [:hick]],
             :cup
           ]) == [[:coffee], [[:tea]], [:and, [:hick]]]

    assert rember_star(:sauce, [
             [[:tomato, :sauce]],
             [[:bean], :sauce],
             [:and, [[:flying]], :sauce]
           ]) == [
             [[:tomato]],
             [[:bean]],
             [:and, [[:flying]]]
           ]
  end

  test "insertR_star" do
    assert insertR_star(:roast, :chuck, [
             [:how, :much, [:wood]],
             :could,
             [[:a, [:wood], :chuck]],
             [[[:chuck]]],
             [:if, [:a], [[:wood, :chuck]]],
             :could,
             :chuck,
             :wood
           ]) == [
             [:how, :much, [:wood]],
             :could,
             [[:a, [:wood], :chuck, :roast]],
             [[[:chuck, :roast]]],
             [:if, [:a], [[:wood, :chuck, :roast]]],
             :could,
             :chuck,
             :roast,
             :wood
           ]
  end

  test "occur_star" do
    assert occur_star(:banana, [
             [:banana],
             [
               :split,
               [
                 [[[:banana, :ice]]],
                 [:cream, [:banana]],
                 :sherbet
               ]
             ],
             [:banana],
             [:bread],
             [:banana, :brandy]
           ]) == 5
  end

  test "subst_star" do
    assert subst_star(:orange, :banana, [
             [:banana],
             [
               :split,
               [
                 [[[:banana, :ice]]],
                 [:cream, [:banana]],
                 :sherbet
               ]
             ],
             [:banana],
             [:bread],
             [:banana, :brandy]
           ]) == [
             [:orange],
             [
               :split,
               [
                 [[[:orange, :ice]]],
                 [:cream, [:orange]],
                 :sherbet
               ]
             ],
             [:orange],
             [:bread],
             [:orange, :brandy]
           ]
  end

  test "insertL_star" do
    assert insertL_star(:pecker, :chuck, [
             [:how, :much, [:wood]],
             :could,
             [[:a, [:wood], :chuck]],
             [[[:chuck]]],
             [:if, [:a], [[:wood, :chuck]]],
             :could,
             :chuck,
             :wood
           ]) == [
             [:how, :much, [:wood]],
             :could,
             [[:a, [:wood], :pecker, :chuck]],
             [[[:pecker, :chuck]]],
             [:if, [:a], [[:wood, :pecker, :chuck]]],
             :could,
             :pecker,
             :chuck,
             :wood
           ]
  end

  test "member_star" do
    assert member_star(:chips, [
             [:potato],
             [:chips, [[:with], :fish], [:chips]]
           ])
  end

  test "leftmost" do
    assert leftmost([
             [:potato],
             [:chips, [[:with], :fish], [:chips]]
           ]) == :potato
  end

  test "eqlist?" do
    assert eqlist?(
             [:strawberry, :ice, :cream],
             [:strawberry, :ice, :cream]
           )

    refute eqlist?(
             [:strawberry, :ice, :cream],
             [:strawberry, :cream, :ice]
           )

    refute eqlist?(
             [:banana, [[:split]]],
             [[:banana], [:split]]
           )

    refute eqlist?(
             [:beef, [[:sausage]], [:and, [:soda]]],
             [:beef, [[:salami]], [:and, [:soda]]]
           )

    assert eqlist?(
             [:beef, [[:sausage]], [:and, [:soda]]],
             [:beef, [[:sausage]], [:and, [:soda]]]
           )
  end
end
