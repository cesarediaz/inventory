# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def advice(object, head, message)
    html = ''
    if  #{object}
      html = html + '<div id="advice-quarter" >'
      html = html + "<a href=\"#\" onclick=\"Effect.toggle('advice-quarter', 'appear'); return false;\">"
      html = html +  head + '</a>'
      html = html +  '<br>'
      html = html +  message
      html = html +  '</div>'
    end
    return html

  end

  def check(value)
    html = ''
    if value
      html = html +  t('phrases.y')
    else
      html = html +  t('phrases.n')
    end
    return html
  end

end
