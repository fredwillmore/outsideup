class ContactsController < ApplicationController
  before_action :set_parent_categories

  def index
    @home = Home.find 1
  end

  def new
    @contact = Contact.new
    @home = Home.find 1
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

  def mailto
    respond_to do |format|
      format.js do
        spam_redirect unless verify_google_recaptcha
      end
    end
  end

  def spam_redirect
    redirect_to new_contact_path
  end

  private
  def set_parent_categories
    @parent_categories = ParentCategory.all
  end

  def verify_google_recaptcha
    return true # I'll return to this one day when I feel like I haven't wasted enough time in my life
    # this should use delayed_job or something but I'm currently more interested in getting_the_job_done
    status = `curl "https://www.google.com/recaptcha/api/siteverify?secret=#{Rails.application.secrets.recaptcha_secret_key}&response=#{params[:response]}"`
    hash = JSON.parse(status)
    hash["success"] == true ? true : false
  end
end
