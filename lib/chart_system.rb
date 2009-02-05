module ChartSystem
  protected

  #Take the collected values and strings, total_count where is the value
  #of the sum between all the elements for the stats and elements what is
  #a string to make the instance variable in the pie3d method
  #
  #Return a pie_3d chart link to get the chart graph from Google Api
  def google_chart(collect_values, collect_strings, total_count, elements, title)
    @data = []
    @labels = []
    @elements = elements

    @collect_values_position = 0
    @chart_values_position = 0
    collect_values.collect { |x|
      if x > 0
        @percent = (x * 100) / total_count
        @data << @percent
        @labels[@chart_values_position] = collect_strings[@collect_values_position] + ' ' + @percent.to_s + '%'
        @chart_values_position = @chart_values_position + 1
      end
      @collect_values_position = @collect_values_position + 1
    }

    pie3d(@data, @labels, @elements, title)
  end

  #Get the below params:
  #data: values to make the chart portions in the graph
  #labels: to show the labels in the graph
  #elements: to make the instance var in the eval function
  #
  #Return: the instance var with the values to use in Google Api
  #        Chart method
  def pie3d(data, labels, elements, title)
    eval %"

    @#{elements} = GoogleChart.new
    @#{elements}.title = title
    @#{elements}.type = :pie_3d
    @#{elements}.data = data
    @#{elements}.colors = '346000'
    @#{elements}.labels = labels

    ";
  end

end
