class Admin::ItemsController < ApplicationController
  layout 'admin'
  # TODO: this display_order functionality would be a nice thing to package as a gem
  before_action :set_item, only: [:show, :edit, :update, :destroy, :move_up, :move_down]
  before_filter :admin_required

  # GET /items
  # GET /items.json
  def index
    @parent_categories = ParentCategory.all.order(:display_order)
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to admin_item_path(@item), notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to admin_item_path(@item), notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to admin_items_url }
      format.json { head :no_content }
    end
  end

  # TODO: this display_order functionality would be a nice thing to package as a gem
  def move_up
    notice = @item.move_up
    redirect_to admin_items_path, notice: notice
  end

  def move_down
    notice = @item.move_down
    redirect_to admin_items_path, notice: notice
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
      @item.orderable :display_order, :category_id # I'm already calling this in Item::initialize, but apparently `find` doesn't ever `initialize` - be a lot cooler if it did...
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:display_order, :name, :description, :category_id, :photo)
    end
end
