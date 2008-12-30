module ComputersHelper

  def url_google_graph_pie_3d(hash)

    link_to 'Graphic Stats',
    GoogleChart.pie_3d_350x100(hash).to_url,
    options = { :popup => true }

  end

end
