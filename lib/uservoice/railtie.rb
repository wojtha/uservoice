require 'rails/railtie'

module Uservoice
  class Railtie < Rails::Railtie

    initializer "uservoice.initialize_configuration" do
      config_file = Rails.root.join('config', 'uservoice.yml')
      if File.exist?(config_file)
        Uservoice.load_configuration(config_file)
      end
    end

    initializer "uservoice.extend.action_view" do
      ActionView::Base.send(:include, Uservoice::UservoiceViewHelpers)
    end
  end
end
