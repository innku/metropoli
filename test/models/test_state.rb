require 'helper'

class TestState < ActiveSupport::TestCase
  
  def setup
    jal = Factory(:state, :name => 'Nueva villa')
  end
  
  test 'like method should find states by name' do
    assert_equal Metropoli::StateModel.like('Nueva villa').count, 1
    assert_equal Metropoli::StateModel.like('Nuevo Leon').count, 1
  end
  
  test 'like method should find states with %' do
    assert_equal Metropoli::StateModel.like('nue').count, 2
  end
  
  test 'like method should return all states with blank' do
    assert_equal Metropoli::StateModel.like('').count, Metropoli::StateModel.count
  end
  
  test 'like method should return all states with nil' do
    assert_equal Metropoli::StateModel.like(nil).count, Metropoli::StateModel.count
  end
  
  test 'autocomplete method should find states with or without country' do
    assert_equal Metropoli::StateModel.autocomplete('Nuevo Leon').count, 1
    assert_equal Metropoli::StateModel.autocomplete('Nuevo Leon, MX').count, 1
  end
  
  test 'autocomplete method should find states with country full name' do
    assert_equal Metropoli::StateModel.autocomplete('Nuevo Leon, Mexico').count, 1
    assert_equal Metropoli::StateModel.autocomplete('Nueva vill, Mexi').count, 1
  end
  
  test 'autocomplete method should scope state with provided country' do
    assert_equal Metropoli::StateModel.autocomplete('Monterrey, BO').count, 0
  end
  
  test 'autocomplete method should return all states with blank' do
    assert_equal Metropoli::StateModel.autocomplete('').count, Metropoli::StateModel.count
  end
  
  test 'autocomplete method should return all states with nil' do
    assert_equal Metropoli::StateModel.autocomplete(nil).count, Metropoli::StateModel.count
  end
  
end
