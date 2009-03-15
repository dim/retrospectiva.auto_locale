ApplicationController.class_eval do

  protected

    # Set RetroI18n locale
    def set_locale
      codes = parse_request_header_for_locale_codes + [RetroCM[:general][:basic][:locale]]
      I18n.locale = RetroI18n.guess(*codes)
    end
    
  private
  
    def parse_request_header_for_locale_codes
      request.accept_language.to_s.split(/\s*,\s*/).map do |str|
        str.split(/\s*;\s*/)
      end.sort_by do |loc, q|
        (q || 1).to_i
      end.reverse.map(&:first)
    end

end    
