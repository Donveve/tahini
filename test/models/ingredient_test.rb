require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
  
  test "new_from_string" do
    i = Ingredient.new_from_string("2 ml aceite", nil)
    assert_equal(2, i.number)
    assert_equal('ml', i.unit)
    assert_equal('aceite', i.name)
    assert_equal(6, i.multiply(3).number)  

    i = Ingredient.new_from_string("2 1/2 kg papas", nil)
    assert_equal(2.5, i.number)
    assert_equal('kg', i.unit)
    assert_equal('papas', i.name)
    assert_equal(5, i.multiply(2).number)

    i = Ingredient.new_from_string("3 naranjas", nil)
    assert_equal(3, i.number)
    assert_equal(nil, i.unit)
    assert_equal('naranjas', i.name)

    i = Ingredient.new_from_string("pimienta negra", nil)
    assert_equal(nil, i.number)
    assert_equal(nil, i.unit)
    assert_equal('pimienta negra', i.name)

    i = Ingredient.new_from_string("1 taza maní tostado", nil)
    assert_equal(1, i.number)
    assert_equal('taza', i.unit)
    assert_equal('maní tostado', i.name)

    i = Ingredient.new_from_string("32 sacchetti pane raffermo", nil)
    assert_equal(32, i.number)
    assert_equal(nil, i.unit)
    assert_equal('sacchetti pane raffermo', i.name)

    i = Ingredient.new_from_string("300.0 g harina de trigo", nil)
    assert_equal(300, i.number)
    assert_equal('g', i.unit)
    assert_equal('harina de trigo', i.name)

    i = Ingredient.new_from_string("2.5 gr nuez moscada", nil)
    assert_equal(2.5, i.number)
    assert_equal('gr', i.unit)
    assert_equal('nuez moscada', i.name)
    
    i = Ingredient.new_from_string("sal", nil)
    assert_equal(nil, i.number)
    assert_equal(nil, i.unit)
    assert_equal('sal', i.name)        
  end
  
  test "parse_amount" do
    i = Ingredient.new
    assert_equal(35.6, i.send(:parse_amount, 35.6))
    assert_equal(1, i.send(:parse_amount, '1'))
    assert_equal(0.2, i.send(:parse_amount, '1/5'))
    assert_equal(3.5, i.send(:parse_amount, '3 1/2'))
    assert_raise (StandardError) { i.send(:parse_amount, '2 4 1/2') }  
  end
end
