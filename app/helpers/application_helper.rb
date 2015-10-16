module ApplicationHelper
    
    def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
     end
#Permite agregar un botón de cerrado a los flash message.
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end
  
  def show_link_face(link_text, link_source)
  link_to("#{content_tag :i, nil, class: 'btn btn-facebook'} #{link_text}".html_safe,
    link_source, class: "btn")
  end
  
#Para redireccionar autenticación de omniauth  
  def signin_path(provider)
    "/auth/#{provider.to_s}"
  end


 
end
