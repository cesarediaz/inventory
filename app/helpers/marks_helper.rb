module MarksHelper
  def models(mark)
    content_tag :div, options = {:class => 'background_simple_lists'} do
      mark.model.collect {|x|
        content_tag('div', x.description)
      }
    end
  end
end
