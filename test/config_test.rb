require "test_helper"

class UservoiceConfigTest < ActiveSupport::TestCase
  def setup
    config_file = Rails.root.join('config', 'uservoice.yml')
    if File.exist?(config_file)
      Uservoice.load_configuration(config_file)
    end
  end

  def test_return_config_from_yml
    assert_equal({"sso_key" => "test_sso_key", "script_key" => "test_script_key", "subdomain" => "test_domain"}, Uservoice.config)
  end

  def test_can_be_overwritten
    Uservoice.config.merge!("subdomain" => "my_subdomain")
    assert_equal({"sso_key" => "test_sso_key", "script_key" => "test_script_key", "subdomain" => "my_subdomain"}, Uservoice.config)
  end
end
