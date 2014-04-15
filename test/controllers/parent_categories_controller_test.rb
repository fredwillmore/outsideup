require 'test_helper'

class ParentCategoriesControllerTest < ActionController::TestCase
  setup do
    @parent_category = parent_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parent_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parent_category" do
    assert_difference('ParentCategory.count') do
      post :create, parent_category: { description: @parent_category.description, display_order: @parent_category.display_order, name: @parent_category.name }
    end

    assert_redirected_to parent_category_path(assigns(:parent_category))
  end

  test "should show parent_category" do
    get :show, id: @parent_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parent_category
    assert_response :success
  end

  test "should update parent_category" do
    patch :update, id: @parent_category, parent_category: { description: @parent_category.description, display_order: @parent_category.display_order, name: @parent_category.name }
    assert_redirected_to parent_category_path(assigns(:parent_category))
  end

  test "should destroy parent_category" do
    assert_difference('ParentCategory.count', -1) do
      delete :destroy, id: @parent_category
    end

    assert_redirected_to parent_categories_path
  end
end
