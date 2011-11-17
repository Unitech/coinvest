require 'test_helper'

class AdminActionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get projets_en_attente" do
    get :projets_en_attente
    assert_response :success
  end

  test "should get profils_utilisateur" do
    get :profils_utilisateur
    assert_response :success
  end

end
