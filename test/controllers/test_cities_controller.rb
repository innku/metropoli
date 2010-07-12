require 'helper'

class TestCitiesController < ActionController::TestCase
  tests Metropoli::CitiesController
  
  test 'It should respond with success on json' do
    get :index, :format => :json
    assert_response :success
    assert_not_nil assigns(:cities)
  end
  
end