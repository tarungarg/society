require 'test_helper'

class ElectionsParticipatedUsersControllerTest < ActionController::TestCase
  setup do
    @elections_participated_user = elections_participated_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:elections_participated_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create elections_participated_user" do
    assert_difference('ElectionsParticipatedUser.count') do
      post :create, elections_participated_user: { electon_id: @elections_participated_user.electon_id, user_id: @elections_participated_user.user_id }
    end

    assert_redirected_to elections_participated_user_path(assigns(:elections_participated_user))
  end

  test "should show elections_participated_user" do
    get :show, id: @elections_participated_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @elections_participated_user
    assert_response :success
  end

  test "should update elections_participated_user" do
    patch :update, id: @elections_participated_user, elections_participated_user: { electon_id: @elections_participated_user.electon_id, user_id: @elections_participated_user.user_id }
    assert_redirected_to elections_participated_user_path(assigns(:elections_participated_user))
  end

  test "should destroy elections_participated_user" do
    assert_difference('ElectionsParticipatedUser.count', -1) do
      delete :destroy, id: @elections_participated_user
    end

    assert_redirected_to elections_participated_users_path
  end
end
