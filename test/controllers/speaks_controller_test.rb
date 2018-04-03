require 'test_helper'

class SpeaksControllerTest < ActionController::TestCase
  setup do
    @speak = speaks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:speaks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create speak" do
    assert_difference('Speak.count') do
      post :create, speak: {  }
    end

    assert_redirected_to speak_path(assigns(:speak))
  end

  test "should show speak" do
    get :show, id: @speak
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @speak
    assert_response :success
  end

  test "should update speak" do
    patch :update, id: @speak, speak: {  }
    assert_redirected_to speak_path(assigns(:speak))
  end

  test "should destroy speak" do
    assert_difference('Speak.count', -1) do
      delete :destroy, id: @speak
    end

    assert_redirected_to speaks_path
  end
end
