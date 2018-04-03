require 'test_helper'

class OnlineformsControllerTest < ActionController::TestCase
  setup do
    @onlineform = onlineforms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:onlineforms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create onlineform" do
    assert_difference('Onlineform.count') do
      post :create, onlineform: { body: @onlineform.body, disclose: @onlineform.disclose, title: @onlineform.title, user_id: @onlineform.user_id }
    end

    assert_redirected_to onlineform_path(assigns(:onlineform))
  end

  test "should show onlineform" do
    get :show, id: @onlineform
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @onlineform
    assert_response :success
  end

  test "should update onlineform" do
    patch :update, id: @onlineform, onlineform: { body: @onlineform.body, disclose: @onlineform.disclose, title: @onlineform.title, user_id: @onlineform.user_id }
    assert_redirected_to onlineform_path(assigns(:onlineform))
  end

  test "should destroy onlineform" do
    assert_difference('Onlineform.count', -1) do
      delete :destroy, id: @onlineform
    end

    assert_redirected_to onlineforms_path
  end
end
