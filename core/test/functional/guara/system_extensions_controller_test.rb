require 'test_helper'

module Guara
  class SystemExtensionsControllerTest < ActionController::TestCase
    setup do
      @system_extension = system_extensions(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:system_extensions)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create system_extension" do
      assert_difference('SystemExtension.count') do
        post :create, system_extension: { enabled: @system_extension.enabled, name: @system_extension.name }
      end
  
      assert_redirected_to system_extension_path(assigns(:system_extension))
    end
  
    test "should show system_extension" do
      get :show, id: @system_extension
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @system_extension
      assert_response :success
    end
  
    test "should update system_extension" do
      put :update, id: @system_extension, system_extension: { enabled: @system_extension.enabled, name: @system_extension.name }
      assert_redirected_to system_extension_path(assigns(:system_extension))
    end
  
    test "should destroy system_extension" do
      assert_difference('SystemExtension.count', -1) do
        delete :destroy, id: @system_extension
      end
  
      assert_redirected_to system_extensions_path
    end
  end
end
