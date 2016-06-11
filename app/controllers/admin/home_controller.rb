class Admin::HomeController < ApplicationController
  before_filter :admin_required
  layout 'admin'
  before_filter :home

  def home
    @home ||= Home.find(1)
  end

  def index
    # @parent_categories = ParentCategory.all.order(:display_order).slice 0,3
  end

  def show
    render action: :index
  end

  def edit
  end

  def update
    if @home.update home_params
      render action: :index
    else
      render action: :index
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def home_params
    params.require(:home).permit(:content, :phone)
  end

end