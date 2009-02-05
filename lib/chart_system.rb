module ChartSystem
  protected

  def google_chart(collect_values, collect_strings, all, elements)
    @data = []
    @labels = []
    @elements = elements

    @collect_values_position = 0
    @chart_values_position = 0
    collect_values.collect { |x|
      if x > 0
        @percent = (x * 100) / all
        @data << @percent
        @labels[@chart_values_position] = collect_strings[@collect_values_position] + ' ' + @percent.to_s + '%'
        @chart_values_position = @chart_values_position + 1
      end
      @collect_values_position = @collect_values_position + 1
    }

    pie3d(@data, @labels, @elements)
  end

  def pie3d(data, labels, elements)
    eval %"

    @#{elements} = GoogleChart.new
    @#{elements}.type = :pie_3d
    @#{elements}.data = data
    @#{elements}.colors = '346000'
    @#{elements}.labels = labels

    ";
  end

end
