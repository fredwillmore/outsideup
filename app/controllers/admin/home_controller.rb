class Admin::HomeController < ApplicationController
  layout 'admin'
  def index
    # @parent_categories = ParentCategory.all.order(:display_order).slice 0,3
  end
end