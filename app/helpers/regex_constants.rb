module RegexConstants
  MEXICAN_PHONE           = /^\+52\d{10}$/.freeze
  MONEY                   = /\A[+-]?\d+(\.\d{1,6})?\z/.freeze
  PROPER_NOUN             = /\A\p{L}[\p{L}'\.\-]*( [\p{L}'\.\-]+)*\z/u.freeze
  URL_SAFE                = /\A[a-z][\w\-]*\z/.freeze
  URL                     = %r{^(https?|ftp)://[^\s/$.?#].[^\s]*$}i.freeze
  UUID                    = /\A[\da-f]{8}-([\da-f]{4}-){3}[\da-f]{12}\z/i.freeze
end