module APIConventions
  include HashTransformer

  def camelize_keys(a_hash, first_letter = :lower, deep: true, max_levels: 256)
    transform_keys a_hash, deep: deep, max_levels: max_levels do |key|
      key.to_s.camelize first_letter
    end
  end
end