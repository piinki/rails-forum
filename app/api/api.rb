class API < Grape::API
  include BaseAPI
  include Grape::Extensions::Hashie::Mash::ParamBuilder

  mount API::V1
end
