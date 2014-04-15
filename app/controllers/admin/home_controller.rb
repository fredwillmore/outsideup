class Admin::HomeController < ApplicationController
  def index
    # @parent_categories = ParentCategory.all.order(:display_order).slice 0,3
  end
end