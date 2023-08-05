module SchemaValidable
  #
  # Metodo que valida datos en base a un Schema
  #
  # @param [Hash] request_data datos a validar
  # @param [Dry::Validation::Contract] schema Schema de validacion
  #
  # @return [Hash]
  #
  # @raise [Error::UnprocessableEntityError]
  #
  def validate_request(request_data: get_inferred_params, schema: get_inferred_schema)
    validated_params = schema.call(request_data)

    if validated_params.failure?
      raise Error::UnprocessableEntity.new(
        meta: { validation_errors: validated_params.errors.to_hash }
      )
    end

    validated_params.to_h
  end

  private

  def get_inferred_params
    params.permit!.to_h
  end

  def get_inferred_schema
    name = "Schemas::App::#{controller_name.camelize}::#{action_name.camelize}"
    name.constantize.new
  end
end
