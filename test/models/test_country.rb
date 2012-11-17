require 'helper'

class TestCountry < ActiveSupport::TestCase
  
  test 'like method should find countries by name' do
    assert_equal Metropoli::CountryModel.like('Mexico').count, 1
    assert_equal Metropoli::CountryModel.like('Bol').count, 1
  end
  
  test 'like method should find countries with %' do
    assert_equal Metropoli::CountryModel.like('bo').count, 1
  end
  
  test 'like method should return all countries with blank' do
    assert_equal Metropoli::CountryModel.like('').count, Metropoli::CountryModel.count
  end
  
  test 'like method should return all countries with nil' do
    assert_equal Metropoli::CountryModel.like(nil).count, Metropoli::CountryModel.count
  end
  
  test 'autocomplete method should find states with name' do
    assert_equal Metropoli::CountryModel.autocomplete('Mexico').count, 1
    assert_equal Metropoli::CountryModel.autocomplete('Boli').count, 1
  end
  
  test 'autocomplete method should return all countries with blank' do
    assert_equal Metropoli::CountryModel.autocomplete('').count, Metropoli::CountryModel.count
  end
  
  test 'autocomplete method should return all countries with nil' do
    assert_equal Metropoli::CountryModel.autocomplete(nil).count, Metropoli::CountryModel.count
  end
  
end
