require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
    test 'visting the landing page' do 
        visit root_url
        assert_selector 'h1', text: 'Hello, World'
    end
end