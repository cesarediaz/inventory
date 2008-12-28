module ComputersHelper

  def url_google_graph(availables, unavailables)

    link_to 'Graphic Stats',  GoogleChart.pie_3d_350x150('availables'.capitalize => availables,'unavailables'.capitalize => unavailables).to_url

  end

end
