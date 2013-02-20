# This module represents an encrypted token
# to authenticate a user against the uservoice
# service.
#
# Author::    Alexander Greim  (mailto:alexxx@iltempo.de)
# Copyright:: Copyright (c) 2010 il tempo
# License::   Distributes under the same terms as Ruby

module Uservoice
  class Token
    attr_reader :data

    def self.default(options)
      subdomain = Uservoice.config[:subdomain]
      sso_key = Uservoice.config[:sso_key]

      if options[:sso] && options[:sso][:guid]
        sso_data = options.delete(:sso)
        Uservoice::Token.new(subdomain, sso_key, sso_data).escape!
      end
    end

    # Creates a sign-in token to authenticate user against
    # the uservoice service.
    # See http://developer.uservoice.com/docs/single-sign-on-how-to for
    # data properties available.
    def initialize(subdomain, sso_key, data)
      data.merge!({:expires => (Time.zone.now.utc + 5 * 60).to_s})

      crypt_key = EzCrypto::Key.with_password(subdomain, sso_key)
      encrypted_data = crypt_key.encrypt(data.to_json)

      # Remove line returns where are annoyingly placed every 60 characters
      @data = Base64.encode64(encrypted_data).gsub(/\n/, '')
    end

    # If you are not using rails url helpers to add the token to the url
    # then you will also need to url encode it
    def escape
      CGI.escape(@data)
    end

    def escape!
      @data = CGI.escape(@data)
    end

    def to_s #:nodoc:
      @data
    end

  end
end
