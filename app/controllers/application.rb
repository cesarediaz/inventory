# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class AuditLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    "#{msg} #{timestamp.to_formatted_s(:db)}\n"
  end
end

class ApplicationController < ActionController::Base
  filter_parameter_logging :password

  helper :all # include all helpers, all the time

  include AuthenticatedSystem
  include SearchSystem

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '5b68184176331109ee7b9f6ed3f7d3bb'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password


  def generateUniqueHexCode( codeLength )
    validChars = ("A".."F").to_a + ("0".."9").to_a
    length = validChars.size
    hexCode = ""
    1.upto(codeLength) { |i| hexCode << validChars[rand(length-1)] }
    hexCode
  end

  def models
    @models = Model.find(:all,
                         :select => 'id, description',
                         :conditions => [ "mark_id = ?", params[:mark_id]])
    render  :partial => 'models'
  end

  PER_PAGE = 10


  before_filter :set_user_language

  private

  def set_user_language
      I18n.locale = current_user.language if logged_in?
  end


  def login_as(user)
    logfile = File.open("#{RAILS_ROOT}" + '/log/audit.log', 'a')
    audit_log = AuditLogger.new(logfile)
    audit_log.info 'Logged in as ' + user
  end

  def logout_as(user)
    logfile = File.open("#{RAILS_ROOT}" + '/log/audit.log', 'a')
    audit_log = AuditLogger.new(logfile)
    audit_log.info 'Logout as ' + user
  end

  def update_done_by(controller, action, user, params)
    logfile = File.open("#{RAILS_ROOT}" + '/log/audit.log', 'a')
    audit_log = AuditLogger.new(logfile)
    text = ''
    params.collect { |x| text = text + '|' + x[0].to_s + ' = ' + x[1].to_s}
    audit_log.info user + '|' + controller + '|' + action + text
  end

  def created_by(controller, action, user, params)
    logfile = File.open("#{RAILS_ROOT}" + '/log/audit.log', 'a')
    audit_log = AuditLogger.new(logfile)
    text = ''
    params.collect { |x| text = text + '|' + x[0].to_s + ' = ' + x[1].to_s + '|'}
    audit_log.info user + '|' + controller + '|' + action + text
  end

  def deleted_by(controller, action, user, params)
    logfile = File.open("#{RAILS_ROOT}" + '/log/audit.log', 'a')
    audit_log = AuditLogger.new(logfile)
    audit_log.info user + '|' + controller + '|' + action + '|' + params
  end

end
