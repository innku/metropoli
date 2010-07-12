require 'helper'

class TestCountriesController < ActionController::TestCase
  tests Metropoli::CountriesController
  
  test 'It should respond with success on json' do
    get :index, :format => :json
    assert_response :success
    assert_not_nil assigns(:countries)
  end
  
end