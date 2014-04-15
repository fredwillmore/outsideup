class CatalogController < ApplicationController
  def index
    @parent_categories = ParentCategory.all.order(:display_order).slice 0,3
  end

  def user_profile
    redirect_to "/admin/users/#{current_user.id}#{ can?(:update, User, :id, current_user.id) ? '/edit' : '' }"
  end

  def company_profile
    redirect_to "/admin/companies/#{current_user.company_id}#{ can?(:update, Company, :id, current_user.company_id) ? '/edit' : '' }"
  end
end