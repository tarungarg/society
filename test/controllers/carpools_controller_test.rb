require 'test_helper'

class CarpoolsControllerTest < ActionController::TestCase
  setup do
    @carpool = carpools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carpools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create carpool" do
    assert_difference('Carpool.count') do
      post :create, carpool: { date: @carpool.date, desc: @carpool.desc, routes: @carpool.routes, title: @carpool.title, user_id: @carpool.user_id }
    end

    assert_redirected_to carpool_path(assigns(:carpool))
  end

  test "should show carpool" do
    get :show, id: @carpool
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @carpool
    assert_response :success
  end

  test "should update carpool" do
    patch :update, id: @carpool, carpool: { date: @carpool.date, desc: @carpool.desc, routes: @carpool.routes, title: @carpool.title, user_id: @carpool.user_id }
    assert_redirected_to carpool_path(assigns(:carpool))
  end

  test "should destroy carpool" do
    assert_difference('Carpool.count', -1) do
      delete :destroy, id: @carpool
    end

    assert_redirected_to carpools_path
  end
end
