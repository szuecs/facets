require 'facets/to_hash.rb'
require 'test/unit'


class TestArrayConversion < Test::Unit::TestCase

  def test_to_h
    a = [1,2,3,4]
    x = {1=>2,3=>4}
    assert_equal(x, a.to_h)
  end

  #def test_to_h_odd_number_of_entries
  #  assert_raise(ArgumentError) { [[1,:a],:b].to_h }
  #end

  def test_to_h_flat
    a = [[1,2],3,4,5]
    x = {1=>2,3=>4,5=>nil}
    assert_equal(x, a.to_h_flat)
  end

  def test_to_h_splat
    a = [1,2,3,4,[5,6]]
    x = { 1=>2, 3=>4, [5,6]=>nil }
    assert_equal(x, a.to_h_splat)
  end

  def test_to_h_assoc
    a = [[:a,1],[:b,2],[:c],:d,[:a,5]]
    x = {:a=>[5],:b=>[2],:c=>[],:d=>[]}
    a2 = [ [:a,1,2], [:b,2], [:c], :d ]
    x2 = { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    a3 = [ :x, [:x], [:x,1,2], [:x,3], [:x,4] ]
    x3 = { :x=>[4] }
    assert_equal(x, a.to_h_assoc)
    assert_equal(x2, a2.to_h_assoc)
    assert_equal(x3, a3.to_h_assoc)
  end
  
  def test_to_h_auto
    a = [ [:a,1], [:b,2] ]
    x = { :a=>1, :b=>2 }
    a1 = [ [:a,1,2], [:b,2], [:c], [:d] ]
    x1 = { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    a2 = [ [:a,1,2], 2, :b, [:c,3], 9 ]
    x2 = { [:a,1,2]=>2, :b=>[:c,3], 9=>nil } 
    assert_equal(x, a.to_h_auto)
    assert_equal(x1, a1.to_h_auto)
    assert_equal(x2, a2.to_h_auto)  
  end

  def test_to_h_multi
    a = [[:a,1],[:b,2],[:c],:d,[:a,5]]
    x = {:a=>[1,5],:b=>[2],:c=>[],:d=>[]}
    a2 = [ [:a,1,2], [:b,2], [:c], :d ]
    x2 = { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    a3 = [ [:a,1,2], [:a,3], [:a,4], [:a], :a ]
    x3 = { :a=>[1,2,3,4] }
    assert_equal(x, a.to_h_multi)
    assert_equal(x2, a2.to_h_multi)
    assert_equal(x3, a3.to_h_multi)
  end

  #def test_to_h_assoc_arrayed
  #  a = [[:a,1,2],[:b,3,4],[:c,5,6]]
  #  x = { :a=>[1,2], :b=>[3,4], :c=>[5,6] }
  #  assert_equal(x, a.to_h(true))
  #end

  #def test_to_hash
  #  a = [:a,:b,:c]
  #  assert_equal( { 0=>:a, 1=>:b, 2=>:c }, a.to_hash )
  #end

  def test_to_h_assoc_dispatched
    a = [:a, 1, [:b, 2, :c]]
    assert_equal(a.to_h_assoc, a.to_h(:assoc))
  end
  
  def test_to_h_flat_dispatched
    a = [:a, 1, [:b, 2, :c]]
    assert_equal(a.to_h_flat, a.to_h(:flat))
  end
  
  def test_to_h_multi_dispatched
    a = [:a, 1, [:b, 2, :c]]
    assert_equal(a.to_h_multi, a.to_h(:multi))
  end
  
  def test_to_h_splat_dispatched
    a = [:a, 1, [:b, 2, :c]]
    assert_equal(a.to_h_splat, a.to_h(:splat))
  end

end


class TestEnumerableConversion < Test::Unit::TestCase

  def test_to_h
    a = [[1,:a],[2,:b],[3,:c]]
    x = {1=>:a, 2=>:b, 3=>:c}
    assert_equal(x, a.to_h )
  end

  def test_to_h_flat
    a = [1,2,[3,4]]
    x = {1=>2, 3=>4}
    assert_equal(x, a.to_h_flat)
  end
  
  def test_to_h_multi
    a = [[:a,1,2],[:b,3,4],[:c,5,6]]
    x = {:a=>[1,2], :b=>[3,4], :c=>[5,6]}
    assert_equal(x, a.to_h_multi)
  end

  #def test_to_h_arrayed_flat
  #  a = [1,2,3]
  #  x = {1=>[],2=>[],3=>[]}
  #  assert_equal(x, a.to_h(true))
  #end

  #def test_to_hash
  #  a = [:a,:b,:c]
  #  assert_equal( { 0=>:a, 1=>:b, 2=>:c }, a.to_hash )
  #end

end


class TestHashConversion < Test::Unit::TestCase

  def test_to_h
    a = { :a => 1, :b => 2, :c => 3 }
    assert_equal( a, a.to_h )
  end

  def test_dearray_values
    h = { :a=>[1], :b=>[1,2], :c=>3, :d=>[] }
    x = { :a=>1, :b=>1, :c=>3, :d=>nil }
    assert_equal(x, h.dearray_values)    
  end
  
  def test_dearray_singluar_values
    h = { :a=>[1], :b=>[1,2], :c=>3, :d=>[] }
    x = { :a=>1, :b=>[1,2], :c=>3, :d=>nil }
    assert_equal(x, h.dearray_singluar_values )
  end

end


class TestNilClassConversion < Test::Unit::TestCase

  def test_to_h
    assert_equal( {}, nil.to_h )
  end

end


class TestEnumeratorConversion < Test::Unit::TestCase
  
#  def test_to_h
#    e1 = [[1,:a],[2,:b],[3,:c]].to_enum
#    e2 = [1,2,3,4].to_enum
#    e3 = [:a,1,:b].to_enum
#    assert_equal( { 1=>:a, 2=>:b, 3=>:c }, e1.to_h )
#    assert_equal( {1=>2, 3=>4}, e2.to_h)
#    assert_equal( {:a=>1,:b=>nil}, e3.to_h)
#  end

  def test_to_h
    e = [1,2,3,4].to_enum
    x = {1=>2,3=>4}
    assert_equal(x, e.to_h)
  end

  def test_to_h_flat
    e = [[1,2],3,4,5].to_enum
    x = {1=>2,3=>4,5=>nil}
    e2 = [:a,1,[:b,2,:c]].to_enum
    x2 = { :a=>1, :b=>2, :c=>nil }        
    e3 = [[:a,1],[:b,2]].to_enum
    x3 = { :a=>1, :b=>2 }    
    assert_equal(x, e.to_h_flat)
    assert_equal(x, e.to_h(:flat))
    assert_equal(x2, e2.to_h_flat)
    assert_equal(x2, e2.to_h(:flat))
    assert_equal(x3, e3.to_h_flat)
    assert_equal(x3, e3.to_h(:flat))
  end

  def test_to_h_splat
    e = [1,2,3,4,[5,6]].to_enum
    x = { 1=>2, 3=>4, [5,6]=>nil }
    e2 = [:a,1,:b,2,:c].to_enum
    x2 = { :a=>1, :b=>2, :c=>nil }
    assert_equal(x, e.to_h_splat)
    assert_equal(x, e.to_h(:splat))
    assert_equal(x2, e2.to_h_splat)
    assert_equal(x2, e2.to_h(:splat))
  end

  def test_to_h_assoc
    e = [[:a,1],[:b,2],[:c],:d,[:a,5]].to_enum
    x = {:a=>[5],:b=>[2],:c=>[],:d=>[]}
    e2 = [ [:a,1,2], [:b,2], [:c], :d ].to_enum
    x2 = { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    e3 = [ :x, [:x], [:x,1,2], [:x,3], [:x,4] ].to_enum
    x3 = { :x=>[4] }
    assert_equal(x, e.to_h_assoc)
    assert_equal(x, e.to_h(:assoc))
    assert_equal(x2, e2.to_h_assoc)
    assert_equal(x2, e2.to_h(:assoc))
    assert_equal(x3, e3.to_h_assoc)
    assert_equal(x3, e3.to_h(:assoc))
  end
  
  def test_to_h_auto
    e = [ [:a,1], [:b,2] ].to_enum
    x = { :a=>1, :b=>2 }
    e1 = [ [:a,1,2], [:b,2], [:c], [:d] ].to_enum
    x1 = { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    e2 = [ [:a,1,2], 2, :b, [:c,3], 9 ].to_enum
    x2 = { [:a,1,2]=>2, :b=>[:c,3], 9=>nil } 
    assert_equal(x, e.to_h_auto)
    assert_equal(x1, e1.to_h_auto)
    assert_equal(x2, e2.to_h_auto)  
  end  

  def test_to_h_multi
    e = [[:a,1],[:b,2],[:c],:d,[:a,5]].to_enum
    x = {:a=>[1,5],:b=>[2],:c=>[],:d=>[]}
    e2 = [ [:a,1,2], [:b,2], [:c], :d ]
    x2 = { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    e3 = [ [:a,1,2], [:a,3], [:a,4], [:a], :a ]
    x3 = { :a=>[1,2,3,4] }
    assert_equal(x, e.to_h_multi)
    assert_equal(x, e.to_h(:multi))
    assert_equal(x2, e2.to_h_multi)
    assert_equal(x2, e2.to_h(:multi))
    assert_equal(x3, e3.to_h_multi)
    assert_equal(x3, e3.to_h(:multi))
  end
  
end