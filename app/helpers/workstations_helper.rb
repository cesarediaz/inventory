# This file is part of Hardware Inventory.
#
#     Copyright (C) 2009 Cesar Diaz
#
#     Hardware Inventory is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program. If not, see <http://www.gnu.org/licenses/>.

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
    html = html + "<div id='stats_data_centered'>"
    html = html + t('stats.alone') + ':' + @out rescue nil + t('phrases.units')
    html = html + '</div>'


    eval %" @in = #{object}.list_for_place_as_part_a_workstation(place).count.to_s rescue nil";
    html = html +  "<div id='stats_data_centered'>"
    html = html +  t('stats.workstation') + ':' + @in rescue nil +  "t('phrases.units')"
    html = html +  '</div>'

    return html
  end


  def continue_as_part_of_this_workstation()
   'Continue as part of this workstation?<BR>' \
    + check_box("device", "still_there",options = {:checked => true}, "yes", "no")
  end

end
