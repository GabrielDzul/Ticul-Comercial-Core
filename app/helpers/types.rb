module Types
  include Dry.Types()

  StrippedString = Types::String.constructor(&:strip).constrained(max_size: 255)
  StrippedPhone = Types::String.constructor(&:strip).constrained(max_size: 20)

  MexicanPhone = Types::String.constructor(&:strip).constrained(format: RegexConstants::MEXICAN_PHONE)
  Email = Types::String.constructor(&:strip).constrained(format: URI::MailTo::EMAIL_REGEXP)
  Url = Types::String.constructor(&:strip).constrained(format: URI.regexp)

  UUID = Types::String.constrained(format: RegexConstants::UUID)

  LATITUDE = Types::Params::Decimal.constrained(gteq: -90, lteq: 90)
  LONGITUDE = Types::Params::Decimal.constrained(gteq: -180, lteq: 180)
end