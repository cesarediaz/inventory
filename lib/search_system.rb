module SearchSystem
  protected

  def search_by(elements, model, data, field, limit)
    eval %"

    @#{elements} = #{model}.find(:all,
                               :conditions => [ '#{field} LIKE ?',
                                                '%' + '#{data}' + '%' ],
                               :order => '#{field} ASC',
                               :limit => #{limit})

    ";
  end

end
