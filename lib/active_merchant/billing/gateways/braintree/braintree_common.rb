module BraintreeCommon
  def self.included(base)
    base.supported_countries = %w(US CA AD AT BE BG HR CY CZ DK EE FI FR GI DE GR GG HU IS IM IE IT JE LV LI LT LU MT MC NL NO PL PT RO SM SK SI ES SE CH TR GB SG HK MY AU NZ)
    base.supported_cardtypes = %i[visa master american_express discover jcb diners_club maestro]
    base.homepage_url = 'http://www.braintreepaymentsolutions.com'
    base.display_name = 'Braintree'
    base.default_currency = 'USD'
    base.currencies_without_fractions = %w(BIF CLP DJF GNF JPY KMF KRW LAK PYG RWF UGX VND VUV XAF XOF XPF)
  end

  def supports_scrubbing
    true
  end

  def scrub(transcript)
    return '' if transcript.blank?

    transcript.
      gsub(%r((Authorization: Basic )\w+), '\1[FILTERED]').
      gsub(%r((&?ccnumber=)\d*(&?)), '\1[FILTERED]\2').
      gsub(%r((&?cvv=)\d*(&?)), '\1[FILTERED]\2').
      gsub(%r((<account-number>)\d+(</account-number>)), '\1[FILTERED]\2').
      gsub(%r((<payment-method-nonce>)[^<]+(</payment-method-nonce>)), '\1[FILTERED]\2').
      gsub(%r((<payment-method-token>)[^<]+(</payment-method-token>)), '\1[FILTERED]\2').
      gsub(%r((<value>)[^<]{100,}(</value>)), '\1[FILTERED]\2').
      gsub(%r((<token>)[^<]+(</token>)), '\1[FILTERED]\2').
      gsub(%r((<cryptogram>)[^<]+(</cryptogram>)), '\1[FILTERED]\2').
      gsub(%r((<number>)[^<]+(</number>)), '\1[FILTERED]\2')
  end
end
