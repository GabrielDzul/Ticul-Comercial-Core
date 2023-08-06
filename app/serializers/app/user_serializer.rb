module App
  class UserSerializer < ActiveModel::Serializer
    include NullAttributesRemover

    attributes :id,
               :phone,
               :email,
               :status,
               :paternal_surname,
               :maternal_surname,
               :name,
               :is_email_confirmed

    def is_email_confirmed
      object.email_confirmed?
    end
  end
end