module MarksHelper
  def models(mark)
    if not mark.model.empty?
      content_tag :div, options = {:class => 'background_simple_lists'} do
        mark.model.collect {|x|
          content_tag :div do
            x.description
          end
       }
      end
    end
  end

  def links_delete_models(mark)
    if not mark.model.empty?
      content_tag :div, options = {:class => 'background_simple_lists'} do
        mark.model.collect {|x|
          content_tag :div do
            link_to_remote t('common_actions.destroy'),
            :url  => model_url(x), :method => :delete,
            :update => { :success => "outer", :failure => "error" }
          end
       }
      end
    end
  end

  def links_edit_models(mark)
    if not mark.model.empty?
      content_tag :div, options = {:class => 'background_simple_lists'} do
        mark.model.collect {|x|
          content_tag :div do
            link_to(t('common_actions.edit'), edit_model_path(x.id))
          end
       }
      end
    end
  end

  def list(mark)
    if not mark.model.empty?
      html = ''
      html = html + '<table width="100%" cellspacing ="0px" cellpadding ="0px" >'
      html = html + '<tr>'
      html = html + '<td>'
      html = html + models(mark)
      html = html + '</td>'
      html = html + '<td>'
      html = html + links_edit_models(mark)
      html = html + '</td>'
      html = html + '<td>'
      html = html + links_delete_models(mark)
      html = html + '</td>'
      html = html + '</tr>'
      html = html + '</table>'
      return html
    end
  end
end
