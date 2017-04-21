require 'test_helper'

class ContactsControllerTest < ActionController::TestCase

  test "should render index" do
    get :index
    assert_response :success
  end

  test "should render js for mailto" do
    xhr :get, :mailto, format: :js
    assert_response :success
  end

end
