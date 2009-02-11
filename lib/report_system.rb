module ReportSystem
  protected

  #Take the collected values and strings, total_count where is the value
  #of the sum between all the elements for the stats and elements what is
  #a string to make the instance variable in the pie3d method
  #
  #Return a pie_3d chart link to get the chart graph from Google Api
  def xls_report(path, head, model, elements, fields, param_id)

    eval %"

     # Creamos un nuevo archivo Excel en disco
     workbook = Excel.new('#{RAILS_ROOT}#{path}')
     # Añadimo hoja INSCRIPTOS
     head = workbook.add_worksheet('#{head}')

     # Row de cabecera
     @head = #{fields}
     columna = 0
     @head.each do |cab|
      head.write(0,columna,cab)
      columna += 1
     end

     # Una row para cada empresa
     @#{elements} = #{model}.list_for_place(#{param_id})

     row = 1
     for c in @#{elements}
      # Añado la row con los datos en sus respectivas columnas
      head.write(row,0,c.name)
      head.write(row,1,c.mac)
      head.write(row,2,c.ip)
      # Pasamos al siguiente tutor en una nueva row
      row += 1
    end

    # Cerramos el libro
    workbook.close
    # Enviamos el fichero al navegador
    send_file '#{RAILS_ROOT}#{path}'

    ";
  end

end
