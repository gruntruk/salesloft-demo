require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'show#home' do 
    get root_url
    assert_response :success
  end

  test 'default route' do 
    assert_generates '/', controller: 'home', action: 'show'
  end
end
