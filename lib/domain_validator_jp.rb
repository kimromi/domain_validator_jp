require "domain_validator_jp/version"
require "public_suffix"

class DomainValidatorJp
  attr_reader :domain

  def initialize(domain)
    @domain = domain
  end

  def valid?
    return false if include_subdomain?
    return false unless valid_public_suffix?
    return false unless valid_length_domain?

    true
  end

  def parsed
    @parsed ||= PublicSuffix.parse(domain)
  end

  def sld
    parsed.sld
  end

  def tld
    parsed.tld
  end

  def include_subdomain?
    !parsed.subdomain.nil?
  end

  def valid_length_domain?
    domain.length <= 253
  end

  def valid_public_suffix?
    PublicSuffix.valid?(domain, default_rule: nil, ignore_private: true)
  end
end
