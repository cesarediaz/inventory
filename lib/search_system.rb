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

module SearchSystem
  protected

  def search_by(elements, model, data, field, limit)
    eval %"

    @#{elements} = #{model}.find(:all,
                               :conditions => [ '#{field} LIKE ?',
                                                '%' + '#{data}' + '%' ],
                               :order => '#{field} ASC',
                               :limit => #{limit})

    ";
  end

end
