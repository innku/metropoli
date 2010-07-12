require 'helper'

class TestStatesController < ActionController::TestCase
  tests Metropoli::StatesController
  
  test 'It should respond with success on json' do
    get :index, :format => :json
    assert_response :success
    assert_not_nil assigns(:states)
  end
  
end