module WorkstationsHelper

  #Generate html showing small stats resumes of devices
  #
  #Params: label  data label
  #        object model objet
  #        place  id reference of place
  #
  #Return: html
  def statistics(label, object, place)
    html = ''
    html = html + "<div id='stats_data'>"
    eval %" @total = #{object}.list_for_place(place).count.to_s rescue nil ";
    html = html +  label + ':' +  @total rescue nil  + t('phrases.units')
    html = html +  '</div>'

    eval %" @out = #{object}.list_for_place_are_not_part_a_workstation(place).count.to_s rescue nil ";
    html = html + "<div place='stats_data_centered'>"
    html = html + t('stats.alone') + ':' + @out rescue nil + t('phrases.units')
    html = html + '</div>'


    eval %" @in = #{object}.list_for_place_as_part_a_workstation(id).count.to_s rescue nil";
    html = html +  "<div id='stats_data_centered'>"
    html = html +  t('stats.workstation') + ':' + @in rescue nil +  "t('phrases.units')"
    html = html +  '</div>'

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

end
