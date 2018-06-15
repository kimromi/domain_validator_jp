require "domain_validator_jp/version"
require "public_suffix"

module DomainValidatorJp
  class << self
    def valid?(domain)
      return false unless valid_public_suffix?(domain)
      true
    end

    def valid_public_suffix?(domain)
      PublicSuffix.valid?(domain, default_rule: nil, ignore_private: true)
    end
  end
end
