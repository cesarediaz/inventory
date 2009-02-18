# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def advice(object)
    html = ''
   if  #{object}
     html = html + '<div id="advice-quarter" >'
     html = html + "<a href=\"#\" onclick=\"Effect.toggle('advice-quarter', 'appear'); return false;\">"
     html = html +  t('common-actions.hide-advice') + '</a>'
     html = html +  '<br>'
     html = html +  t('help-phrases.in-workstation')
     html = html +  '</div>'
   end
    return html

  end

end
