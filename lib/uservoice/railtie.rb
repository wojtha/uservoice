require 'rails/railtie'

ActionView::Base.send(:include, Uservoice::UservoiceViewHelpers)

module Uservoice
  class Railtie < Rails::Railtie
    railtie_name :uservoice
  end
end
