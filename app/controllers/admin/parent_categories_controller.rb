class Admin::ParentCategoriesController < ApplicationController
  layout 'admin'
  before_action :set_parent_category, only: [:show, :edit, :update, :destroy, :move_up, :move_down]
  before_filter :admin_required

  # GET /parent_categories
  # GET /parent_categories.json
  def index
    @parent_categories = ParentCategory.all.order(:display_order)
  end

  # GET /parent_categories/1
  # GET /parent_categories/1.json
  def show
  end

  # GET /parent_categories/new
  def new
    @parent_category = ParentCategory.new
  end

  # GET /parent_categories/1/edit
  def edit
  end

  # POST /parent_categories
  # POST /parent_categories.json
  def create
    @parent_category = ParentCategory.new(parent_category_params)

    respond_to do |format|
      if @parent_category.save
        format.html { redirect_to admin_parent_category_path(@parent_category), notice: 'Parent category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @parent_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @parent_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parent_categories/1
  # PATCH/PUT /parent_categories/1.json
  def update
    respond_to do |format|
      if @parent_category.update(parent_category_params)
        format.html { redirect_to admin_parent_category_path(@parent_category), notice: 'Parent category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parent_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parent_categories/1
  # DELETE /parent_categories/1.json
  def destroy
    @parent_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_parent_categories_url }
      format.json { head :no_content }
    end
  end

  # TODO: this display_order functionality would be a nice thing to package as a gem
  def move_up
    notice = @parent_category.move_up
    redirect_to admin_parent_categories_path, notice: notice
  end

  def move_down
    notice = @parent_category.move_down
    redirect_to admin_parent_categories_path, notice: notice
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent_category
      @parent_category = ParentCategory.find(params[:id])
      @parent_category.orderable :display_order # I'm already calling this in Category::initialize, but apparently `find` doesn't ever `initialize` - be a lot cooler if it did...
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parent_category_params
      params.require(:parent_category).permit(:display_order, :name, :description, :photo)
    end
end
