class ContactsController < ApplicationController
  before_action :set_parent_categories
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:error] = nil
      flash.now[:notice] = 'Thank you for your message!'
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end

  private
  def set_parent_categories
    @parent_categories = ParentCategory.all
  end
end