require 'test_helper'

class MikusControllerTest < ActionController::TestCase
  setup do
    @miku = mikus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mikus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create miku" do
    assert_difference('Miku.count') do
      post :create, miku: { feeling: @miku.feeling, states: @miku.states }
    end

    assert_redirected_to miku_path(assigns(:miku))
  end

  test "should show miku" do
    get :show, id: @miku
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @miku
    assert_response :success
  end

  test "should update miku" do
    patch :update, id: @miku, miku: { feeling: @miku.feeling, states: @miku.states }
    assert_redirected_to miku_path(assigns(:miku))
  end

  test "should destroy miku" do
    assert_difference('Miku.count', -1) do
      delete :destroy, id: @miku
    end

    assert_redirected_to mikus_path
  end
end
