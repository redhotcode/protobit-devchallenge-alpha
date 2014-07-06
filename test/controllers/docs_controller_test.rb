require 'test_helper'

class DocsControllerTest < ActionController::TestCase
  test "should display readme successfully" do
    get :readme
    assert_response :success, "Wrong response received."
    assert_template layout: 'layouts/application'
    assert_equal css_select('.panel-body').length, 3, "Not all panel bodies rendered."
    assert_equal css_select('.panel-body > h1').length, 3, "Not all markdown documents rendered."
  end
end
