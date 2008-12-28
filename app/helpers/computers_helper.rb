module ComputersHelper

  def url_google_graph_pie_3d(availables, unavailables)

    link_to 'Graphic Stats',
    GoogleChart.pie_3d_350x100('availables' => availables,
                               'unavailables' => unavailables).to_url,
    options = { :popup => true }

  end

end
