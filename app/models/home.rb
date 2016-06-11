class Home < ActiveRecord::Base

  def display_content
    content.gsub(/:phone/, display_phone).gsub(/:company_name/, display_company_name).gsub(/\n[^\S\n]*\n/, '<br>').html_safe
  end

  def display_company_name
    "<strong><i>OutsideUP</i></strong>"
  end

  def display_phone
    "<strong><a href=\"tel:#{phone.gsub /[^\d]/, '' }\" class=\"phone\">#{phone}</a></strong>"
  end

  # <strong><a href=\"tel:+15034814484\" class=\"phone\">503.481.4484</a></strong>
end
