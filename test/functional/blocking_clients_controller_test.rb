require 'test_helper'

class BlockingClientsControllerTest < ActionController::TestCase
  setup do
    @blocking_client = blocking_clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blocking_clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blocking_client" do
    assert_difference('BlockingClient.count') do
      post :create, blocking_client: { blocking_client_id: @blocking_client.blocking_client_id, car_number: @blocking_client.car_number, lat: @blocking_client.lat, long: @blocking_client.long }
    end

    assert_redirected_to blocking_client_path(assigns(:blocking_client))
  end

  test "should show blocking_client" do
    get :show, id: @blocking_client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blocking_client
    assert_response :success
  end

  test "should update blocking_client" do
    put :update, id: @blocking_client, blocking_client: { blocking_client_id: @blocking_client.blocking_client_id, car_number: @blocking_client.car_number, lat: @blocking_client.lat, long: @blocking_client.long }
    assert_redirected_to blocking_client_path(assigns(:blocking_client))
  end

  test "should destroy blocking_client" do
    assert_difference('BlockingClient.count', -1) do
      delete :destroy, id: @blocking_client
    end

    assert_redirected_to blocking_clients_path
  end
end
