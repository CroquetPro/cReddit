module ApplicationHelper
  def flash_helper
    html = ''
    if flash.now[:errors]
      flash.now[:errors].each do |error|
        html += "#{error}<br>"
      end
    end
    if flash[:notice]
      flash[:notice].each do |notice|
        html += "#{notice}<br>"
      end
    end
    html.html_safe
  end

  def auth_token
    "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}'>".html_safe
  end
end
