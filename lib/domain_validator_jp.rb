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
    return false unless valid_sld_not_dotted?
    return false unless valid_sld_not_start_with_hyphen?
    return false unless valid_sld_not_end_with_hyphen?

    if sld_multibyte?
      return false unless valid_length_sld_multibyte?
      return false unless valid_jisx0208?
    else
      return false unless valid_sld_chars?
      return false unless valid_length_domain?
      return false unless valid_length_sld?
    end

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

  # common

  def include_subdomain?
    !parsed.subdomain.nil?
  end

  def valid_public_suffix?
    PublicSuffix.valid?(domain, default_rule: nil, ignore_private: true)
  end

  def valid_sld_not_dotted?
    sld !~ /\./
  end

  def valid_sld_not_start_with_hyphen?
    sld !~ /^\-/
  end

  def valid_sld_not_end_with_hyphen?
    sld !~ /\-$/
  end

  # only multibyte

  def sld_multibyte?
    sld !~ /^[0-9A-Za-z\-]+$/
  end

  def valid_length_sld_multibyte?
    1 <= sld.length && sld.length <= 15
  end

  # only multibyte

  def valid_sld_chars?
    sld =~ /^[0-9A-Za-z\-]+$/
  end

  def valid_length_domain?
    domain.length <= 253
  end

  def valid_length_sld?
    sld.length <= 63
  end

  def valid_jisx0208?
    valid = /^#{utf8_to_sjis("[\-0-9A-Za-zぁ-んァ-ヶ亜-腕弌-熙]")}+$/
    valid.match(utf8_to_sjis(sld)) if utf8_to_sjis(sld)
  end

  def utf8_to_sjis(str)
    str.encode('Windows-31J') rescue nil
  end
end
