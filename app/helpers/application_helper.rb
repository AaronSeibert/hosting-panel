module ApplicationHelper

  def modal_flash(object, type)
    render "global/forms/modal_flash", :object => object, :type => type
  end
  
  def flash_class(level)
    case level
      when :success then "alert-success"
      when :notice then "alert-info"
      when :error then "alert-error"
      when :alert then "alert-warning"
    end
  end
  
  
  # Dynamic form handlers
  
end