module ReportSystem
  protected


  #This method generate a xls file to download
  #
  #Parameters:
  # path: way where the xls file will be save in the server application
  # worksheet: name of worksheet
  # model: model of data to get
  # elements: name that will be provide to the array when we get records
  # heads: the names of first row in the xls file
  # method: is the name of method to implment in the rescue of records
  # param_id: parameter to provide the place from we need get records
  #
  #Return a .xls file with the report
  def xls_report(path, worksheet, model, elements, heads, method, param_id)

    eval %"

     workbook = Excel.new('#{RAILS_ROOT}#{path}')
     head = workbook.add_worksheet('#{worksheet}')

     @heads = #{heads}
     columna = 0
     @heads.each do |cab|
      head.write(0,columna,cab)
      columna += 1
     end

     @#{elements} = #{model}.#{method}(#{param_id})


    report_of(elements, head, @#{elements})
    workbook.close
    send_file '#{RAILS_ROOT}#{path}'

    ";
  end

  def report_of(type, head, elements)
    case type
    when 'computers'
      computers_report(head, elements)
    when 'screens'
      screens_report(head, elements)
    when 'printers'
      printers_report(head, elements)
    end
  end

  def computers_report(head, elements)
    row = 1
     for object in elements
       head.write(row,0,object.name)
       head.write(row,1,object.mac)
       head.write(row,2,object.ip)
       row += 1
     end
  end

  def screens_report(head, elements)
    row = 1
     for object in elements
       head.write(row,0,object.model)
       head.write(row,1,object.serialnumber)
       row += 1
     end
  end

  def printers_report(head, elements)
    row = 1
     for object in elements
       head.write(row,0,object.model)
       head.write(row,1,object.serialnumber)
       row += 1
     end
  end

end
