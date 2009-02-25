# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Take and object and depending if it is true make a help advice
  #
  # Return: html
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

  #Get a value and depending of the value return a phrase
  #
  #Return: - yes if value is true
  #        - no if value is false
  def check(value)
    html = ''
    if value
      html = html +  t('phrases.y')
    else
      html = html +  t('phrases.n')
    end
    return html
  end

  #Get a value and depending of the value return a link or a phrase
  #
  #Return: - link if value is true
  #        - no if value is false
  def in_workstation?(value)
    html = ''
    if value.is_part_of_a_workstation
      html = html +  link_to(t('phrases.y'), :controller => 'workstations',
                             :action => 'show',
                             :id => Workstation.find(:first,
                                                     :conditions => [ "computer_id = ?", value.id]).id)
    else
      html = html +  t('phrases.n')
    end
    return html
  end

end
