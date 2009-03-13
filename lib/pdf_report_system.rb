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

module PdfReportSystem
  protected

  #This method generate a pdf file to download
  #
  #Parameters:
  # elements: data to fill the pdf to download
  # paper: type of paper to generate the printable file(e.g. A4,
  #        LETTER and so on)
  # title: title of the pdf file report
  # font_size: size of the letters in the file
  # columns_order: order that will be display the columns in the
  # pdf file if this file will show a table with data
  #
  #Return a .pdf file with the report
  def pdf_report(elements, paper, title, font_size, columns_order, type)
    pdf = PDF::Writer.new(:paper => paper)
    pdf.select_font "Times-Roman"
    pdf.start_page_numbering(500, 50, 10, nil, nil, 1)

    pdf.image 'public/images/block-pen.jpg', :justification => :right, :resize => 0.30
    pdf.text title, :font_size => font_size, :justification => :center, :spacing => 2

    PDF::SimpleTable.new do |tab|
      case type
      when 'bills'
        columns_bills_pdf_report(tab, columns_order)
      when 'places'
        columns_places_pdf_report(tab, columns_order)
      end


      data = []
      for content in elements
        case type
        when 'bills'
          data << data_bills_report(content)
        when 'places'
          data << data_places_report(content)
        end
      end

      tab.data.replace data
      tab.render_on(pdf)
    end

    send_data pdf.render, :filename => title, :type => 'application/pdf'
  end


  #This method generate a pdf file to download
  #
  #Parameters:
  # element: data to fill the pdf to download
  # paper: type of paper to generate the printable file(e.g. A4,
  #        LETTER and so on)
  # title: title of the pdf file report
  # font_size: size of the letters in the file
  # pdf file if this file will show a table with data
  #
  #Return a .pdf file with the report
  def single_pdf_report(element, paper, title, font_size, type)
    pdf = PDF::Writer.new(:paper => paper)
    pdf.select_font "Times-Roman"
    pdf.start_page_numbering(500, 50, 10, nil, nil, 1)

    pdf.image 'public/images/block-pen.jpg', :justification => :right, :resize => 0.30
    pdf.text title, :font_size => font_size, :justification => :center, :spacing => 2

    PDF::SimpleTable.new do |tab|
      case type
      when 'computer'
        pdf.text t('computers.place') + ': ' + element.place.title
        pdf.text t('computers.name') + ': ' + element.name
        pdf.text 'Ip: ' + element.ip
        pdf.text 'Mac: ' + element.mac
        pdf.text element.motherboard.model rescue nil
        pdf.text t('computers.inventory_register') +
          ' ' + element.inventory_register rescue nil
        element.memory.collect {|x| pdf.text t('computers.memory') + ': ' + x.model
          + ' ' + x.size.to_s  + ' ' + x.unit.upcase }  rescue nil
        element.harddisk.collect {|x| pdf.text t('computers.harddisk') + ': ' +  x.model
          + ' ' + x.size.to_s + ' ' + x.unit.upcase }  rescue nil
        element.cd.collect {|x| pdf.text 'Cd: ' + x.model + ' ' +  x.mark.name }  rescue nil
        element.dvd.collect {|x| pdf.text 'Cd: '+ x.model + ' ' + x.mark.name }  rescue nil
      end
    end

    send_data pdf.render, :filename => title, :type => 'application/pdf'
  end

  #Report of places
  #
  #Parameters:
  # tab: object to add tab columns in the pdf file report
  # columns_order: order of the columns
  #
  #Return the content of the pdf file report
  def columns_places_pdf_report(tab, columns_order)
    tab.column_order = columns_order
    tab.text_color = Color::RGB::Black
    tab.show_lines = :none

      tab.columns["col1"] = PDF::SimpleTable::Column.new("col1") { |col|
        col.width = 200
        col.heading = t('places.description')
      }

      tab.columns["col2"] = PDF::SimpleTable::Column.new("col2") { |col|
        col.width = 80
        col.heading = t('places.description')
      }

      tab.columns["col3"] = PDF::SimpleTable::Column.new("col2") { |col|
        col.width = 80
        col.heading = t('places.computer')
      }

      tab.columns["col4"] = PDF::SimpleTable::Column.new("col4") { |col|
        col.width = 80
        col.heading = t('places.screen')
      }

      tab.columns["col5"] = PDF::SimpleTable::Column.new("col5") { |col|
      col.width = 80
        col.heading = t('places.printer')
      }
  end

  #Data to fill each column in the report
  #
  #Parameters:
  # content: content to write in the pdf file
  #
  #Return the data loaded in each row of the places report
  def data_places_report(content)
    { "col1" => "#{content.title}", "col2" => "#{content.description}" \
        , "col3" => "#{content.computer.count}", "col4" => "#{content.screen.count}" \
        , "col5" => "#{content.printer.count}"}
  end



  #Report of bills
  #
  #Parameters:
  # tab: object to add tab columns in the pdf file report
  # columns_order: order of the columns
  #
  #Return the content of the pdf file report
  def columns_bills_pdf_report(tab, columns_order)
    tab.column_order = columns_order
    tab.text_color = Color::RGB::Black
    tab.show_lines = :none

    tab.columns["col1"] = PDF::SimpleTable::Column.new("col2") { |col|
      col.width = 280
      col.heading = t('bill.company')
    }

    tab.columns["col2"] = PDF::SimpleTable::Column.new("col1") { |col|
      col.width = 50
      col.heading = t('bill.code')
    }

    tab.columns["col3"] = PDF::SimpleTable::Column.new("col2") { |col|
      col.width = 100
      col.heading = t('bill.date')
    }

  end

  #Data to fill each column in the report
  #
  #Parameters:
  # content: content to write in the pdf file
  #
  #Return the data loaded in each row of the bills report
  def data_bills_report(content)
    { "col1" => "#{content.company.name}", "col2" => "#{content.code}" \
        , "col3" => "#{content.date.strftime("%d/%m/%Y")}"}
  end

end
