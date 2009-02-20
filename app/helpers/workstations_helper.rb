module WorkstationsHelper

  def statistics(object, id)
    html = ''
    html = html + "<div id='stats_data'>"
    html = html +  t('workstations.computer') + ':' +  #{object}.list_for_place(id).count.to_s rescue nil + t('phrases.units')
    html = html +  '</div>'

    html = html + "<div id='stats_data_centered'>"
    html = html + t('stats.alone') + ':' + #{object}.list_for_place_are_not_part_a_workstation(id).count.to_s rescue nil + t('phrases.units')
    html = html + '</div>'
    html = html +  "<div id='stats_data_centered'>"
    html = html +  t('stats.workstation') + ':' + #{object}.list_for_place_as_part_a_workstation(id).count.to_s rescue ni +  "t('phrases.units')"
    html = html +  '</div>'

    return html
  end
end
