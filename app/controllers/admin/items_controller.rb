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
        # TODO: this display_order functionality would be a nice thing to package as a gem
        if @item.category_id_changed?
          @item.get_display_order.save!
          Item.where(category_id: @item.category_id).where("display_order > ?", @item.display_order).each do |i|
            i.dec
          end
        end
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
    # TODO: this display_order functionality would be a nice thing to package as a gem
    Item.where(category_id: @item.category_id).where("display_order > ?", @item.display_order).each do |i|
      i.dec
    end
    @item.destroy
    respond_to do |format|
      format.html { redirect_to admin_items_url }
      format.json { head :no_content }
    end
  end

  # TODO: this display_order functionality would be a nice thing to package as a gem
  def move_up
      if @item.display_order > 1
      Item.where(display_order: @item.display_order-1, category_id: @item.category_id ).first.inc
      @item.dec
      notice = "Successfully moved #{@item.name} to position #{@item.display_order}"
    else
      notice = "#{@item.name} is already in the top position"
    end
    redirect_to admin_items_path, notice: notice
  end

  def move_down
    i = Item.where(display_order: @item.display_order+1, category_id: @item.category_id ).first
    if i
      i.dec
      @item.inc
      notice = "Successfully moved #{@item.name} to position #{@item.display_order}"
    else
      notice = "#{@item.name} is already in the bottom position"
    end
    redirect_to admin_items_path, notice: notice
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:display_order, :name, :description, :category_id, :photo)
    end
end
