# TODO: this display_order functionality would be a nice thing to package as a gem
module Orderable

  mattr_accessor :order_field
  mattr_accessor :parent_id

  def orderable(order_field, parent_id=nil)
    self.order_field = order_field
    self.parent_id = parent_id
  end

  def inc
    self.increment! order_field, 1
  end

  def dec
    self.decrement! order_field, 1
  end

  def shuffle_up
    return unless id
    self.class.where(
        parent_id => self.class.find(id).send(parent_id)
    ).where(
        "#{order_field.to_s} > ?", send(order_field)
    ).each do |i|
      i.dec
    end
  end

  def reset_display_order
    if changes[parent_id]
      shuffle_up
      update_column order_field, (self.class.where.not(id: id).where(parent_id => send(parent_id)).order("#{order_field.to_s} DESC").first.send(order_field) rescue 0)+1
    end
  end

  def move_up
    if send(order_field) > 1
      where = {order_field => send(order_field)-1}
      where[parent_id] = send(parent_id) if parent_id
      c = self.class.where(where).first
      if c
        c.inc
      end
      dec
      notice = "Successfully moved #{name} to position #{send(order_field)}"
    else
      notice = "#{name} is already in the top position"
    end
    notice
  end

  def move_down
    where = {order_field => send(order_field)+1}
    where[parent_id] = send(parent_id) if parent_id
    c = self.class.where(where).first
    if c
      c.dec
      inc
      notice = "Successfully moved #{name} to position #{send(order_field)}"
    else
      notice = "#{name} is already in the bottom position"
    end
    notice
  end

end