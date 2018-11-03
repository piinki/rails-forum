module BaseAPI
  extend ActiveSupport::Concern

  included do
    prefix "api"
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers
    default_format :json

    rescue_from Grape::Exceptions::ValidationErrors, ActiveRecord::RecordNotUnique do |e|
      raise_errors e.full_messages[0].to_s, Settings.error_formatter.http_code.validation_errors
    end

    rescue_from APIError::Base, JWT::VerificationError, JWT::DecodeError do |e|
      error_key =
        if e.is_a? APIError::Base
          e.class.name.demodulize.underscore
        else
          :unauthenticated
        end
      http_code = Settings.error_formatter.http_code.public_send error_key
      raise_errors I18n.t(error_key, scope: "api_error"), http_code
    end

    rescue_from ActiveRecord::UnknownAttributeError, ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid,
      JSON::ParserError do |e|
      raise_errors e.as_json, Settings.error_formatter.http_code.data_operation
    end

    rescue_from ActiveRecord::RecordNotDestroyed do |e|
      raise_errors e.record.errors.full_messages.join(", "), Settings.error_formatter.http_code.data_operation
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      raise_errors I18n.t("api_error.invalid_id", model: e.model, id: e.id), Settings.error_formatter.http_code.record_not_found
    end

    helpers do
      def set_locale
        language = headers["Accept-Language"].present? ? headers["Accept-Language"] : I18n.default_locale.to_s
        I18n.locale = HTTP::Accept::Languages.parse(language)[0].locale
      end

      def authenticate!
        raise APIError::Unauthenticated unless current_user && UserToken.verify(access_token_header)
      end

      def authorize_admin!
        authenticate!
        raise APIError::Unauthorized unless current_user.admin?
      end

      def current_user
        @current_user ||= UserToken.find_by_token(access_token_header)&.user
      end

      def access_token_header
        headers[Settings.access_token_header]
      end

      def raise_errors(message, code)
        error!({ error: { code: code, message: message } }, code)
      end
    end
  end
end
