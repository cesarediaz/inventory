module PlacesHelper
  def url_google_graph_pie_3d(rooms, departments, offices, stores)

    link_to 'Graphic Stats',
    GoogleChart.pie_3d_350x100('rooms' => rooms,
                               'departments' => departments,
                               'offices' => offices,
                               'stores' => stores).to_url,
    options = { :popup => true }

  end
end
