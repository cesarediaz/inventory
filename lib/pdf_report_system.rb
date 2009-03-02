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
  def pdf_report(elements, paper, title, font_size, columns_order)
    pdf = PDF::Writer.new(:paper => paper)
    pdf.select_font "Times-Roman"
    pdf.start_page_numbering(500, 50, 10, nil, nil, 1)

    pdf.image 'public/images/inventory.jpg', :justification => :right, :resize => 0.30
    pdf.text title, :font_size => font_size, :justification => :center, :spacing => 2

    PDF::SimpleTable.new do |tab|
      columns_places_pdf_report(tab, columns_order)

      data = []
      for content in elements
        data << data_places_report(content)
      end

      tab.data.replace data
      tab.render_on(pdf)
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

end
