class Admin::HomeController < ApplicationController
  before_filter :admin_required
  layout 'admin'
  def index
    # @parent_categories = ParentCategory.all.order(:display_order).slice 0,3
  end
end