require 'test_helper'

class ElectionsControllerTest < ActionController::TestCase
  setup do
    @election = elections(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:elections)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create election' do
    assert_difference('Election.count') do
      post :create, election: { voting_end_date: @election.voting_end_date, voting_start_date: @election.voting_start_date, win_user: @election.win_user, years_range: @election.years_range }
    end

    assert_redirected_to election_path(assigns(:election))
  end

  test 'should show election' do
    get :show, id: @election
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @election
    assert_response :success
  end

  test 'should update election' do
    patch :update, id: @election, election: { voting_end_date: @election.voting_end_date, voting_start_date: @election.voting_start_date, win_user: @election.win_user, years_range: @election.years_range }
    assert_redirected_to election_path(assigns(:election))
  end

  test 'should destroy election' do
    assert_difference('Election.count', -1) do
      delete :destroy, id: @election
    end

    assert_redirected_to elections_path
  end
end
