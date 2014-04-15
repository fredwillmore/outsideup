class Admin::ParentCategoriesController < ApplicationController
  before_action :set_parent_category, only: [:show, :edit, :update, :destroy]
  before_filter :admin_required

  # GET /parent_categories
  # GET /parent_categories.json
  def index
    @parent_categories = ParentCategory.all
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
      format.html { redirect_to parent_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent_category
      @parent_category = ParentCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parent_category_params
      params.require(:parent_category).permit(:display_order, :name, :description, :photo)
    end
end
