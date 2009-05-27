module Focus
  
  FIELD_HELPERS = %w( text_field password_field file_field text_area check_box radio_button )
  TAG_HELPERS = %w( text_field_tag password_field_tag file_field_tag text_area_tag check_box_tag radio_button_tag select_tag )
  OPTIONS_HELPERS = %w( select )
  ALL_FOCUSABLE_HELPERS = FIELD_HELPERS + TAG_HELPERS + OPTIONS_HELPERS
  
  module FormHelpers
    
    def self.included(base)
      ALL_FOCUSABLE_HELPERS.each do |h|
        base.alias_method_chain h, :focus
      end
    end
    
    ALL_FOCUSABLE_HELPERS.each do |m|
      # define_method doesn't play well with optional params
      # so we have to finagle with *args
      define_method "#{m}_with_focus" do |*args|
        options = args.length > 2 ? args.last : {}
        map_id = lambda{|a| a.map(&:to_s).join('_')}
        html_id = case m
          when /radio_button_tag/ then map_id[args[0..1]]
          when /radio/ then map_id[args[0..2]]
          when /tag/ then args[0].to_s
          else map_id[args[0..1]]
        end
        focus = options.is_a?(Hash) ? options.delete(:focus) : nil
        args[-1] = options if args.length > 2
        out = send("#{m}_without_focus", *args)
        out += "\n" + javascript_tag("$('#{html_id}').focus()") if focus
        out
      end
    end
    
  end
  
end