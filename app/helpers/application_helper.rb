# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def advice(object, message)
    html = ''
   if  #{object}
     html = html + '<div id="advice-quarter" >'
     html = html + "<a href=\"#\" onclick=\"Effect.toggle('advice-quarter', 'appear'); return false;\">"
     html = html +  t('common-actions.hide-advice') + '</a>'
     html = html +  '<br>'
     html = html +  message
     html = html +  '</div>'
   end
    return html

  end

end
