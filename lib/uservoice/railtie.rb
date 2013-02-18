require 'rails/railtie'

ActionView::Base.send(:include, Uservoice::UservoiceViewHelpers)

module UserVoice
  class Railtie < Rails::Railtie
    railtie_name :uservoice
  end
end
