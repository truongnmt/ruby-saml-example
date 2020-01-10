class Account < ActiveRecord::Base
  def self.get_saml_settings(url_base)
    # this is just for testing purposes.
    # should retrieve SAML-settings based on subdomain, IP-address, NameID or similar
    settings = OneLogin::RubySaml::Settings.new

    url_base ||= "http://localhost:3000"

    # Example settings data, replace this values!

    # When disabled, saml validation errors will raise an exception.
    settings.soft = true

    #SP section
    settings.issuer                         = url_base + "/saml/metadata"
      settings.assertion_consumer_service_url = url_base + "/saml/acs"
    settings.assertion_consumer_logout_service_url = url_base + "/saml/logout"

    onelogin_app_id = "<onelogin-app-id>"

    # IdP section
    settings.idp_entity_id                  = "https://app.onelogin.com/saml/metadata/fed4e0ba-c59b-4098-adfa-17c20814bb57"
    settings.idp_sso_target_url             = "https://hust-dev.onelogin.com/trust/saml2/http-post/sso/fed4e0ba-c59b-4098-adfa-17c20814bb57"
    settings.idp_slo_target_url             = "https://hust-dev.onelogin.com/trust/saml2/http-redirect/slo/1059446"
    #settings.idp_cert                       = ""


    settings.idp_cert_fingerprint           = "8B:52:83:59:1D:48:B9:B0:CB:D4:BE:71:D6:87:7E:0D:4C:20:D4:32"
    settings.idp_cert_fingerprint_algorithm = XMLSecurity::Document::SHA1

    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

    # Security section
    settings.security[:authn_requests_signed] = false
    settings.security[:logout_requests_signed] = false
    settings.security[:logout_responses_signed] = false
    settings.security[:metadata_signed] = false
    settings.security[:digest_method] = XMLSecurity::Document::SHA1
    settings.security[:signature_method] = XMLSecurity::Document::RSA_SHA1

    settings
  end
end
