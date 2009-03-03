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

  # Take and object and depending if it is true make a help advice
  #
  # Return: html
  def show_info(label, css, object, value, field)
    html = "<div id='#{css}'>"
    html = html + label + ' : '
    eval %"
        @value = #{object}.find(:first, :conditions => [ 'id = ?', #{value}]).#{field}
    ";
    html = html +  @value
    html = html + '</div>'
    return html
  end

  # Take and object and depending of the attribute 'description'
  # it will return a translate value
  #
  # Return: html
  def which_type_of_place_is?(place)
    case place
    when 'stores'
      html = t('places.stores')
    when 'offices'
      html = t('places.offices')
    when 'rooms'
      html = t('places.rooms')
    when 'departments'
      html = t('places.departments')
    end

    return html
  end

end
