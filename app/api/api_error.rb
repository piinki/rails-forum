module APIError
  class Base < Grape::Exceptions::Base
    def initialize *args
      if args.length.zero?
        t_key = self.class.name.underscore.tr("/", ".")
        super message: I18n.t(t_key)
      else
        super(*args)
      end
    end
  end

  class Unauthenticated < APIError::Base; end

  class TokenExpired < APIError::Base; end

  class InvalidEmailToken < APIError::Base; end

  class WrongCurrentPassword < APIError::Base; end

  class WrongEmailPassword < APIError::Base; end

  class SendEmailError < APIError::Base; end
end
