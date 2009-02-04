# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  include AuthenticatedSystem

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '5b68184176331109ee7b9f6ed3f7d3bb'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password

  PER_PAGE = 10


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

  before_filter :set_user_language

  private

  def set_user_language
      I18n.locale = current_user.language if logged_in?
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
