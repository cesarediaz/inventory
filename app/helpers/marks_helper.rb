module MarksHelper
  def models(mark)
    if not mark.model.empty?
      content_tag :div, options = {:class => 'background_simple_lists'} do
        mark.model.collect {|x|
          content_tag('div', x.description)
        }
      end
    end
  end
end
