# Make api response camelCase
ActiveModel::Serializer.config.key_transform = :camel_lower
# Ensure all the relationships are serialized
ActiveModel::Serializer.config.default_includes = "**"
# Use JSON-API adapter
ActiveModelSerializers.config.adapter = ActiveModelSerializers::Adapter::JsonApi
# https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/howto/serialize_poro.md
ActiveModelSerializers::Model.derive_attributes_from_names_and_fix_accessors