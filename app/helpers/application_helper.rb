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

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Take and object and depending if it is true make a help advice
  #
  # Return: html
  def advice(object, head, message, width, id)
    html = ''
    if  object
      html = html + '<div class="' + width + '" id="' + id + '" >'
      html = html + "<a href=\"#\" onclick=\"Effect.toggle('" + id + "', 'appear'); return false;\">"
      html = html +  head + '</a>'
      html = html +  '<br>'
      html = html +  message
      html = html +  '</div>'
    end
    return html

  end

  # Take and object and depending if it is true make a help advice
  #
  # Return: html
  def front_end_pages()
    Page.find(:all).collect { |page|
      unless page.frontend == false
        content_tag :div, :id => 'options' do
          link_to(page.permalink, '/' + page.permalink )
        end
      end
    }
  end

  #Get a value and depending of the value return a phrase
  #
  #Return: - yes if value is true
  #        - no if value is false
  def check(value)
    if value
      content_tag('div', t('phrases.y'))
    else
      content_tag('div', t('phrases.n'))
    end
  end

  #Get a value and depending of the value return a link or a phrase
  #
  #Return: - link if value is true
  #        - no if value is false
  def in_workstation?(value, device)
    html = ''
    if value.is_part_of_a_workstation
      html = html +  link_to(t('phrases.y'), :controller => 'workstations',
                             :action => 'show',
                             :id => Workstation.find(:first,
                                                     :conditions => [ "#{device} = ?", value.id]).id)
    else
      html = t('phrases.n')
    end
    return html
  end

  # Take and object and depending if it is true make a help advice
  #
  # Return: html
  def show_info(label, css, object, value, field)
    content_tag :div, :id => '#{css}' do
      content_tag :div do
        label + ' : '
        eval %"
        @value = #{object}.find(:first, :conditions => [ 'id = ?', #{value}]).#{field}
        ";
        @value
      end
    end
  end

  # Take and object and depending of the attribute 'description'
  # it will return a translate value
  #
  # Return: html
  def which_type_of_place_is?(place)

    case place
    when 'store'
      content_tag('div',  t('places.stores'))
    when 'office'
      content_tag('div',  t('places.offices'))
    when 'room'
      content_tag('div', t('places.rooms'))
    when 'classroom'
      content_tag('div', t('places.classrooms'))
    when 'department'
      content_tag('div', t('places.departments'))
    end
  end

  def set_charset
    if logged_in? and  I18n.locale === 'fr'
      @content = '<meta http-equiv="content-type" content= "text/html; charset=iso-8859-1" />'
    else
      @content = '<meta http-equiv="content-type" content= "text/html; charset=utf-8" />'
    end
    return @content
  end

  def notice
    content_tag :div, options = {:class => 'advice'} do
      content_tag('h4', flash[:notice])
    end
  end

end
