module PdfReportSystem
  protected

  def pdf_report(elements, paper, title, font, columns_order, columns_size, columns_header)
    pdf = PDF::Writer.new(:paper => paper)
    pdf.select_font "Times-Roman"
    pdf.text title, :font_size => font, :justification => :center

    PDF::SimpleTable.new do |tab|
      columns_places_pdf_report(tab, columns_order)

      data = []
      for content in elements
        data << data_places_report(content)
      end

      tab.data.replace data
      tab.render_on(pdf)
    end

    send_data pdf.render, :filename => 'mi.pdf', :type => 'application/pdf'

  end

  def columns_places_pdf_report(tab, columns_order)
      tab.column_order = columns_order

      tab.columns["col1"] = PDF::SimpleTable::Column.new("col1") { |col|
        col.width = 100
        col.heading = t('places.description')
      }

      tab.columns["col2"] = PDF::SimpleTable::Column.new("col2") { |col|
        col.width = 70
        col.heading = t('places.description')
      }

      tab.columns["col3"] = PDF::SimpleTable::Column.new("col2") { |col|
        col.width = 70
        col.heading = t('places.computer')
      }

      tab.columns["col4"] = PDF::SimpleTable::Column.new("col4") { |col|
        col.width = 70
        col.heading = t('places.screen')
      }

      tab.columns["col5"] = PDF::SimpleTable::Column.new("col5") { |col|
        col.width = 70
        col.heading = t('places.printer')
      }
  end

  def data_places_report(content)
    { "col1" => "#{content.title}", "col2" => "#{content.description}" \
        , "col3" => "#{content.computer.count}", "col4" => "#{content.screen.count}" \
        , "col5" => "#{content.printer.count}"}
  end

end
