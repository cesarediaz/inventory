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
  # method: is the name of method to implement in the rescue of records
  # param_id: parameter to provide the place from we need get records
  #
  #Return a .xls file with the report
  def xls_report(path, worksheet, model, elements, heads, method, param_id)

    eval %"

     workbook = Excel.new('#{RAILS_ROOT}#{path}')
     page = workbook.add_worksheet('#{worksheet}')

     get_heads(page, heads)
     get_elements(elements, model, method, param_id)
     report_of(elements, page, @#{elements})

     workbook.close
     send_file '#{RAILS_ROOT}#{path}'

    ";
  end

  #This method take the parameters and write in the page of a xls
  #file the heads(first line in each column)
  def get_heads(page, heads)
    eval %"

    @heads = #{heads}
     column = 0
     @heads.each do |cab|
      page.write(0,column,cab)
      column += 1
     end

    ";
  end


  #This method get an array of elements depending of the parameters
  #
  #Parameters:
  # elements: name that will be provide to the array when we get records
  # model: model of data to get
  # method: is the name of method to implement in the rescue of records
  # param_id: parameter to provide the place from we need get records
  #
  #Return an array of elements
  def get_elements(elements, model, method, param_id)
    if param_id.empty?
      eval %"
           @#{elements} = #{model}.#{method}
      ";
    else
      eval %"
           @#{elements} = #{model}.#{method}#{param_id}
      ";
    end
  end

  #This method call distinct methods of reports depending of the type
  # of report elements
  #
  #Parameters:
  # elements: name that will be provide to the array when we get records
  # page: first row of each column
  # elements: array with elements
  #
  #Return: nothing
  def report_of(type, page, elements)
    case type
    when 'computers'
      computers_report(page, elements)
    when 'screens'
      generic_report(page, elements)
    when 'printers'
      generic_report(page, elements)
    when 'places'
      places_report(page, elements)
    end
  end

  #This method fill the the computers report
  def computers_report(page, elements)
    row = 1
     for object in elements
       @disks = ''
       object.harddisk.empty? ? t('phrases.n') : object.harddisk.collect {|x|
       @disks = @disks + x.model + " "} rescue nil
       @memories = ''
       object.memory.empty? ? t('phrases.n') : object.memory.collect {|x|
       @memories = @memories + x.model + " "} rescue nil
       @cds = ''
       object.cd.empty? ? t('phrases.n') : object.cd.collect {|x|
       @cds = @cds + x.model + " "} rescue nil
       @dvds = ''
       object.dvd.empty? ? t('phrases.n') : object.dvd.collect {|x|
       @dvds = @dvds + x.model + " "} rescue nil

       page.write(row,0,object.name)
       page.write(row,1,object.mac)
       page.write(row,2,object.ip)
       page.write(row,3,object.available == true ? t('phrases.y') : t('phrases.n'))
       page.write(row,4,object.mother_board.title.nil? ? t('phrases.n') : object.mother_board.title) rescue nil
       page.write(row,5,@disks)
       page.write(row,6,@memories)
       page.write(row,7,@cds)
       page.write(row,8,@dvds)
       row += 1
     end
  end

  #This method fill the the screens report
  def generic_report(page, elements)
    row = 1
     for object in elements
       page.write(row,0,object.model)
       page.write(row,1,object.serialnumber)
       row += 1
     end
  end


  #This method fill the the places report
  def places_report(page, elements)
    row = 1
     for object in elements
       page.write(row,0,object.title)
       page.write(row,1,object.description)
       page.write(row,2,object.computer.count)
       page.write(row,3,object.screen.count)
       page.write(row,4,object.printer.count)
       row += 1
     end
  end

end
