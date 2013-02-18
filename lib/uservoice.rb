require "ezcrypto"
require "action_view"
require "uservoice/config"
require "uservoice/token"
require "uservoice/view_helpers"

module Uservoice
end

require "uservoice/railtie" if defined?(Rails)
