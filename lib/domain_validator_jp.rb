require "domain_validator_jp/version"
require "public_suffix"

module DomainValidatorJp
  class << self
    def valid?(domain)
      return false unless fqdn?(domain)
      return false if include_subdomain?(domain)
      return false unless valid_public_suffix?(domain)
      return false unless valid_sld_not_dotted?(domain)
      return false unless valid_sld_not_start_with_hyphen?(domain)
      return false unless valid_sld_not_end_with_hyphen?(domain)

      if sld_multibyte?(domain)
        return false unless valid_length_sld_multibyte?(domain)
        return false unless valid_jisx0208?(domain)
      else
        return false unless valid_sld_chars?(domain)
        return false unless valid_length_domain?(domain)
        return false unless valid_length_sld?(domain)
      end

      true
    end

    def fqdn?(domain)
      splitted = domain.split('.')
      splitted.length >= 2 && splitted.all?{|label| !label.empty? }
    end

    def parsed(domain)
      PublicSuffix.parse(domain)
    end

    # common

    def include_subdomain?(domain)
      !parsed(domain).subdomain.nil?
    end

    def valid_public_suffix?(domain)
      PublicSuffix.valid?(domain, default_rule: nil, ignore_private: true)
    end

    def valid_sld_not_dotted?(domain)
      parsed(domain).sld !~ /\./
    end

    def valid_sld_not_start_with_hyphen?(domain)
      parsed(domain).sld !~ /^\-/
    end

    def valid_sld_not_end_with_hyphen?(domain)
      parsed(domain).sld !~ /\-$/
    end

    # only multibyte

    def sld_multibyte?(domain)
      parsed(domain).sld !~ /^[0-9A-Za-z\-]+$/
    end

    def valid_length_sld_multibyte?(domain)
      1 <= parsed(domain).sld.length && parsed(domain).sld.length <= 15
    end

    # only multibyte

    def valid_sld_chars?(domain)
      parsed(domain).sld =~ /^[0-9A-Za-z\-]+$/
    end

    def valid_length_domain?(domain)
      domain.length <= 253
    end

    def valid_length_sld?(domain)
      parsed(domain).sld.length <= 63
    end

    def valid_jisx0208?(domain)
      valid = /^#{utf8_to_sjis("[\-0-9A-Za-z・ヽヾゝゞ仝々〆〇ーぁ-んァ-ヶ亜-腕弌-熙]")}+$/
      valid.match(utf8_to_sjis(parsed(domain).sld)) if utf8_to_sjis(parsed(domain).sld)
    end

    def utf8_to_sjis(str)
      str.encode('Windows-31J') rescue nil
    end
  end
end
