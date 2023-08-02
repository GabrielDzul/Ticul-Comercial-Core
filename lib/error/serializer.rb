module Error
  class Serializer < ActiveModel::Serializer
    attributes :status,
               :code,
               :message,
               :meta

    def error
      object.message
    end

    def detail
      object.meta
    end
  end
end
