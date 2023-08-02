class APIErrorSerializer < ::Error::Serializer
  include APIConventions
  include NullAttributesRemover

  def detail
    camelize_keys(object.meta)
  end
end