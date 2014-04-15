class HomeController < ApplicationController
  before_action :set_parent_categories, only: [:index, :parent_category]

  def index
  end

  def parent_category
    @parent_category = ParentCategory.find(params[:id])
  end

  def user_profile
    redirect_to "/admin/users/#{current_user.id}#{ can?(:update, User, :id, current_user.id) ? '/edit' : '' }"
  end

  def company_profile
    redirect_to "/admin/companies/#{current_user.company_id}#{ can?(:update, Company, :id, current_user.company_id) ? '/edit' : '' }"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_parent_categories
    @parent_categories = ParentCategory.all
  end
end