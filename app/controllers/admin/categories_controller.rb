class Admin::CategoriesController < ApplicationController
  layout 'admin'
  before_action :set_category, only: [:show, :edit, :update, :destroy, :move_up, :move_down]
  before_filter :admin_required

  # GET /categories
  # GET /categories.json
  def index
    @parent_categories = ParentCategory.all.order(:display_order)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        # TODO: this display_order functionality would be a nice thing to package as a gem
        if @category.parent_category_id_changed?
          @category.get_display_order.save!
          Category.where(parent_category_id: @category.parent_category_id).where("display_order > ?", @category.display_order).each do |c|
            c.dec
          end
        end
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    # TODO: this display_order functionality would be a nice thing to package as a gem
    Category.where(parent_category_id: @category.parent_category_id).where("display_order > ?", @category.display_order).each do |c|
      c.dec
    end
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  def move_up
    if @category.display_order > 1
      Category.where(display_order: @category.display_order-1, parent_category_id: @category.parent_category_id ).first.inc
      @category.dec
      notice = "Successfully moved #{@category.name} to position #{@category.display_order}"
    else
      notice = "#{@category.name} is already in the top position"
    end
    redirect_to admin_categories_path, notice: notice
  end

  def move_down
    c = Category.where(display_order: @category.display_order+1, parent_category_id: @category.parent_category_id ).first
    if c
      c.dec
      @category.inc
      notice = "Successfully moved #{@category.name} to position #{@category.display_order}"
    else
      notice = "#{@category.name} is already in the bottom position"
    end
    redirect_to admin_categories_path, notice: notice
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:display_order, :name, :description, :parent_category_id)
    end
end
